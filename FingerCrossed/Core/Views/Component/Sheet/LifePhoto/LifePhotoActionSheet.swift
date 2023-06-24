//
//  LifePhotoActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import GraphQLAPI

struct LifePhotoActionSheet: View {
    /// View controller
    @Environment(\.dismiss) private var dismiss
    /// Banner
    @EnvironmentObject private var bm: BannerManager
    /// Observed basic info view model
    @ObservedObject var basicInfoVM: BasicInfoViewModel
    /// Init view model
    @StateObject private var vm = ViewModel()
    
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
                    if basicInfoVM.hasLifePhoto {
                        Button {
                            vm.deleteOnTap { delete() }
                        } label: {
                            LifePhotoActionRow(actionType: .delete)
                        }
                        
                        Button {
                            vm.showEditSheet = true
                        } label: {
                            LifePhotoActionRow(actionType: .edit)
                        }
                    } else {
                        Button {
                            vm.takePhotosOnTap()
                        } label: {
                            LifePhotoActionRow(actionType: .camera)
                        }
                        .fullScreenCover(
                            isPresented: $vm.showCamera,
                            onDismiss: {
                                guard basicInfoVM.selectedImage != nil else { return }
                                vm.showEditSheet = true
                            },
                            content: {
                                ImagePicker(
                                    sourceType: .camera,
                                    selectedImage: $basicInfoVM.selectedImage
                                )
                                .edgesIgnoringSafeArea(.all)
                            }
                        )
                        .alert(isPresented: $vm.showCameraAlert) {
                            Alert(
                                title:
                                    Text(vm.cameraPermissionManager.alertTitle)
                                    .font(Font.system(size: 18, weight: .medium)),
                                message:
                                    Text(vm.cameraPermissionManager.alertMessage)
                                    .font(Font.system(size: 12, weight: .medium)),
                                primaryButton: .default(Text("Cancel")),
                                secondaryButton: .default(
                                    Text("Settings"),
                                    action: {
                                        UIApplication.shared.open(
                                            URL(string: UIApplication.openSettingsURLString)!
                                        )
                                    }
                                )
                            )
                        }
                        
                        Button {
                            vm.uploadPhotosOnTap()
                        } label: {
                            LifePhotoActionRow(actionType: .photo)
                        }
                        .sheet(
                            isPresented: $vm.showImagePicker,
                            onDismiss: {
                                guard  basicInfoVM.selectedImage != nil else { return }
                                vm.showEditSheet = true
                            },
                            content: {
                                ImagePicker(
                                    sourceType: .photoLibrary,
                                    selectedImage: $basicInfoVM.selectedImage
                                )
                            }
                        )
                        .alert(isPresented: $vm.showPhotoLibraryAlert) {
                            Alert(
                                title:
                                    Text(vm.photoLibraryPermissionManager.alertTitle)
                                    .font(Font.system(size: 18, weight: .medium)),
                                message:
                                    Text(vm.photoLibraryPermissionManager.alertMessage)
                                    .font(Font.system(size: 12, weight: .medium)),
                                primaryButton: .default(Text("Cancel")),
                                secondaryButton: .default(
                                    Text("Settings"),
                                    action: {
                                        UIApplication.shared.open(
                                            URL(string: UIApplication.openSettingsURLString)!
                                        )
                                    }
                                )
                            )
                        }
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
        .sheet(
            isPresented: $vm.showEditSheet,
            onDismiss: {
                basicInfoVM.resetImage()
//                basicInfoVM.selectedImage = nil
                dismiss()
            },
            content: {
                LifePhotoEditSheet(
                    basicInfoVM: basicInfoVM,
                    text: basicInfoVM.selectedLifePhoto?.caption ?? ""
                )
            }
        )
    }
    
    private func delete() {
        Task {
            if let lifePhoto = basicInfoVM.selectedLifePhoto {
                do {
                    try await vm.deleteLifePhoto(
                        lifePhotoId: lifePhoto.id,
                        url: lifePhoto.contentUrl
                    )
                    guard vm.state == .complete else { return }
                    basicInfoVM.lifePhotoMap = basicInfoVM.lifePhotoMap.filter {
                        $0.value.id != lifePhoto.id
                    }
                    dismiss()
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

struct LifePhotoActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoActionSheet(
            basicInfoVM: BasicInfoViewModel()
        )
        .environmentObject(BannerManager())
    }
}

extension LifePhotoActionSheet {
    
    enum ActionType {
        case camera
        case delete
        case edit
        case photo
    }
    
    struct LifePhotoActionRow: View {
        
        @State var actionType: ActionType
        
        var body: some View {
            HStack(spacing: 20) {
                switch actionType {
                case .camera:
                    FCIcon.camera
                    Text("Take Photos")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                case .delete:
                    FCIcon.trash
                    Text("Delete")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                case .edit:
                    FCIcon.edit
                    Text("Edit Photo")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                case .photo:
                    FCIcon.addPicture
                    Text("Upload Photos")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                    
                }
            }
        }
    }
    
}

extension LifePhotoActionSheet {
    
    class ViewModel: ObservableObject {
        
        @AppStorage("UserId") var userId: String = ""

        /// View state
        @Published var state: ViewStatus = .none
        @Published var showEditSheet: Bool = false
        @Published var showCamera: Bool = false
        @Published var showImagePicker: Bool = false
        
        /// Toast message
        @Published var bannerMessage: String?
        @Published var bannerType: Banner.BannerType?

        /// Alert
        @Published var fcAlert: FCAlert?
        @Published var showCameraAlert: Bool = false
        @Published var showPhotoLibraryAlert: Bool = false
        
        /// Permission manager
        let photoLibraryPermissionManager = PhotoLibraryPermissionManager()
        let cameraPermissionManager = CameraPermissionManager()
        
        @MainActor
        public func takePhotosOnTap() {
            switch cameraPermissionManager.permissionStatus {
            case .notDetermined:
                cameraPermissionManager.requestPermission { granted, _ in
                    guard granted else { return }
                    self.showCamera = true
                }
            case .denied:
                self.showCameraAlert = true
            default:
                self.showCamera = true
            }
        }
        
        @MainActor
        public func uploadPhotosOnTap() {
            switch photoLibraryPermissionManager.permissionStatus {
            case .notDetermined:
                photoLibraryPermissionManager.requestPermission { granted, _ in
                    guard granted else { return }
                    self.showImagePicker = true
                }
            case .denied:
                self.showPhotoLibraryAlert = true
            default:
                self.showImagePicker = true
            }
        }
        
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
        public func deleteLifePhoto(
            lifePhotoId: String,
            url: String
        ) async throws {
            self.state = .loading
            guard let fileName = MediaService.extractFileName(url: url) else {
                throw FCError.LifePhoto.extractFilenameFailed
            }
            let url = try await MediaService.getPresignedDeleteUrl(
                .case(.image),
                fileName: fileName
            )
            guard let url = url else { throw FCError.LifePhoto.getPresignedUrlFailed }
            let success = try await AWSS3.deleteObject(presignedURL: url)
            guard success else { throw FCError.LifePhoto.deleteS3ObjectFailed }
            let statusCode = try await MediaService.deleteLifePhoto(
                userId: self.userId,
                lifePhotoId: lifePhotoId
            )
            guard statusCode == 200 else { throw FCError.LifePhoto.updateUserFailed }
            self.state = .complete
        }
    }
    
}
