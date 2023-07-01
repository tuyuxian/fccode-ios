//
//  SelfIntroEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import GraphQLAPI

struct SelfIntroEditSheet: View {

    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var bm: BannerManager
                
    @ObservedObject var user: UserViewModel
    
    @StateObject private var vm = ViewModel()

    @State var text: String
    
    @FocusState private var focus: Bool
    
    var body: some View {
        Sheet(
            size: [.height(402)],
            showDragIndicator: false,
            hasFooter: false,
            header: {
                Text("Self Introduction")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
                    .padding(.bottom, 16)
            },
            content: {
                VStack(spacing: 16) {
                    CaptionInputBar(
                        text: $text,
                        hint: "Type your self introduction",
                        defaultPresentLine: 10,
                        lineLimit: 10,
                        textLengthLimit: vm.textLengthLimit
                    )
                    .frame(height: 244)
                    .padding(.bottom, -10)
                    .onChange(of: text) { val in
                        if val != user.data?.selfIntro {
                            vm.isSatisfied = true
                        } else {
                            vm.isSatisfied = false
                        }
                    }
                    .focused($focus)
                                        
                    PrimaryButton(
                        label: "Save",
                        action: { save(selfIntro: text) },
                        isTappable: $vm.isSatisfied,
                        isLoading: .constant(vm.state == .loading)
                    )
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 24)
                .disabled(vm.state == .loading)
            },
            footer: {}
        )
        .onTapGesture {
            focus = false
        }
        .interactiveDismissDisabled(vm.state == .loading)
        .showAlert($vm.fcAlert)
    }
    
    private func save(
        selfIntro: String
    ) {
        Task {
            await vm.save(text: selfIntro)
            guard vm.state == .complete else { return }
            user.data?.selfIntro = selfIntro
            dismiss()
        }
    }
}

struct SelfIntroEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelfIntroEditSheet(
            user: UserViewModel(preview: true),
            text: ""
        )
        .environmentObject(BannerManager())
    }
}

extension SelfIntroEditSheet {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        @AppStorage("UserId") private var userId: String = ""
                
        /// View state
        @Published var state: ViewStatus = .none
        @Published var isSatisfied: Bool = false
        
        /// Alert
        @Published var fcAlert: FCAlert?
        
        let textLengthLimit: Int = 200
        
        public func save(
            text: String
        ) async {
            do {
                self.state = .loading
                let statusCode = try await UserService.updateUser(
                    userId: self.userId,
                    input: UpdateUserInput(
                        selfIntro: .some(text)
                    )
                )
                guard statusCode == 200 else {
                    throw FCError.SelfIntro.updateUserFailed
                }
                self.state = .complete
            } catch {
                self.state = .error
                self.fcAlert = .info(
                    type: .info,
                    title: "Oopsie!",
                    message: "Something went wrong.",
                    dismissLabel: "Dismiss",
                    dismissAction: {
                        self.state = .none
                        self.fcAlert = nil
                    }
                )
                print(error.localizedDescription)
            }
        }
        
    }
    
}
