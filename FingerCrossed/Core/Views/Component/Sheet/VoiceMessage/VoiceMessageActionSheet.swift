//
//  VoiceMessageActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import GraphQLAPI

struct VoiceMessageActionSheet: View {
    
    /// Banner
    @EnvironmentObject private var bm: BannerManager
    /// Observed user view model
    @ObservedObject var user: UserViewModel
    /// Selected sheet from basic info
    @Binding var selectedSheet: BasicInfoViewModel.SheetView<BasicInfoDestination>?
    /// Init view model
    @StateObject private var vm = ViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Sheet(
            size: [.height(138)],
            hasHeader: false,
            hasFooter: false,
            header: {},
            content: {
                VStack(
                    alignment: .leading,
                    spacing: 30
                ) {
                    Button {
                        vm.deleteOnTap { delete() }
                    } label: {
                        HStack(spacing: 20) {
                            FCIcon.trash
                            Text("Delete")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    
                    Button {
                        vm.showEditSheet = true
                    } label: {
                        HStack(spacing: 20) {
                            FCIcon.edit
                            Text("Edit Voice Message")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    .sheet(
                        isPresented: $vm.showEditSheet,
                        onDismiss: { dismiss() }
                    ) {
                        VoiceMessageEditSheet(
                            user: user,
                            selectedSheet: $selectedSheet
                        )
                    }
                }
                .padding(.top, 15) // 30 - 15
//                .padding(.bottom, 16)
                .showAlert($vm.fcAlert)
                .onChange(of: vm.state) { state in
                    if state == .error {
                        bm.pop(
                            title: vm.bannerMessage,
                            type: vm.bannerType
                        )
                        vm.state = .none
                    }
                }
            },
            footer: {}
        )
    }
    
    private func delete() {
        Task {
            if let url = user.data?.voiceContentURL {
                do {
                    try await vm.deleteVoiceMessage(url: url)
                    guard vm.state == .complete else { return }
                    user.data?.voiceContentURL = ""
                    selectedSheet = nil
                } catch {
                    vm.state = .error
                    vm.bannerMessage = "Something went wrong"
                    vm.bannerType = .error
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct VoiceMessageActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageActionSheet(
            user: UserViewModel(preview: true),
            selectedSheet: .constant(
                BasicInfoViewModel.SheetView(sheetContent: .basicInfoVoiceMessage)
            )
        )
        .environmentObject(BannerManager())
    }
}

extension VoiceMessageActionSheet {
    
    class ViewModel: ObservableObject {
        
        @AppStorage("UserId") var userId: String = ""

        /// View state
        @Published var state: ViewStatus = .none
        @Published var showEditSheet: Bool = false
        
        /// Toast message
        @Published var bannerMessage: String?
        @Published var bannerType: Banner.BannerType?
        
        /// Alert
        @Published var fcAlert: FCAlert?
        
        @MainActor
        public func deleteOnTap(
            action: @escaping () -> Void
        ) {
            self.fcAlert = .action(
                type: .action,
                title: "Do you really want to delete\nit?",
                message: "",
                primaryLabel: "Yes",
                primaryAction: {
                    action()
                    self.fcAlert = nil
                },
                secondaryLabel: "No",
                secondaryAction: {
                    self.fcAlert = nil
                }
            )
        }
        
        @MainActor
        public func deleteVoiceMessage(
            url: String
        ) async throws {
            self.state = .loading
            guard let fileName = MediaService.extractFileName(url: url) else {
                throw FCError.VoiceMessage.extractFilenameFailed
            }
            let url = try await MediaService.getPresignedDeleteUrl(
                .case(.audio),
                fileName: fileName
            )
            guard let url = url else { throw FCError.VoiceMessage.getPresignedUrlFailed }
            let success = try await AWSS3.deleteObject(presignedURL: url)
            guard success else { throw FCError.VoiceMessage.deleteS3ObjectFailed }
            let statusCode = try await UserService.updateUser(
                userId: self.userId,
                input: UpdateUserInput(
                    voiceContentURL: ""
                )
            )
            guard statusCode == 200 else { throw FCError.VoiceMessage.updateUserFailed }
            self.state = .complete
        }
        
    }
    
}
