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
    /// Observed basic info view model
    @ObservedObject var basicInfoVM: BasicInfoViewModel
    /// Init view model
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        Sheet(
            size: [.height(basicInfoVM.hasLifePhoto ? 178 : 124)],
            showDragIndicator: false,
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
                        
                        Button {
                            setToMain()
                        } label: {
                            LifePhotoActionRow(actionType: .setToMain)
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
                .padding(.top, 30)
                .padding(.horizontal, 24)
                .showAlert($vm.fcAlert)
            },
            footer: {}
        )
        .sheet(
            isPresented: $vm.showEditSheet,
            onDismiss: {
                basicInfoVM.resetImage()
                dismiss()
            },
            content: {
                LifePhotoEditSheet(
                    basicInfoVM: basicInfoVM
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
                        url: lifePhoto.contentUrl,
                        position: lifePhoto.position
                    )
                    guard vm.state == .complete else { return }
                    basicInfoVM.lifePhotoMap.removeValue(forKey: lifePhoto.position)
                    var lifePhotos = [LifePhoto]()
                    for var value in basicInfoVM.lifePhotoMap.values {
                        if value.position > lifePhoto.position {
                            value.position -= 1
                        }
                        lifePhotos.append(value)
                    }
                    basicInfoVM.lifePhotoMap = Dictionary(
                        uniqueKeysWithValues: lifePhotos.map { ($0.position, $0) }
                    )
                    dismiss()
                } catch {
                    vm.state = .error
                    vm.showAlert()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setToMain() {
        Task {
            if let sourceLifePhoto = basicInfoVM.selectedLifePhoto,
               var targetLifePhoto = basicInfoVM.lifePhotoMap[0] {
                do {
                    try await vm.setToMainOnTap(
                        sourceLifePhotoId: sourceLifePhoto.id,
                        targetLifePhotoId: targetLifePhoto.id,
                        fromPosition: sourceLifePhoto.position
                    )
                    guard vm.state == .complete else { return }
                    var from = basicInfoVM.lifePhotoMap[sourceLifePhoto.position]
                    from?.position = 0
                    targetLifePhoto.position = sourceLifePhoto.position
                    basicInfoVM.lifePhotoMap[sourceLifePhoto.position] = targetLifePhoto
                    basicInfoVM.lifePhotoMap[0] = from
                    dismiss()
                } catch {
                    vm.state = .error
                    vm.showAlert()
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
    }
}

extension LifePhotoActionSheet {
    
    enum ActionType {
        case camera
        case delete
        case edit
        case photo
        case setToMain
    }
    
    struct LifePhotoActionRow: View {
        
        @State var actionType: ActionType
        
        var body: some View {
            HStack(spacing: 20) {
                switch actionType {
                case .camera:
                    FCIcon.camera
                    Text("Take Photo")
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
                    Text("Upload Photo")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                case .setToMain:
                    FCIcon.star
                    Text("Set to main photo")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                    Spacer()
                    
                }
            }
        }
    }
    
}

extension LifePhotoActionSheet {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        @AppStorage("UserId") var userId: String = ""

        /// View state
        @Published var state: ViewStatus = .none
        @Published var showEditSheet: Bool = false
        @Published var showCamera: Bool = false
        @Published var showImagePicker: Bool = false

        /// Alert
        @Published var fcAlert: FCAlert?
        @Published var showCameraAlert: Bool = false
        @Published var showPhotoLibraryAlert: Bool = false
        
        /// Permission manager
        let photoLibraryPermissionManager = PhotoLibraryPermissionManager()
        let cameraPermissionManager = CameraPermissionManager()
        
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
        
        public func deleteLifePhoto(
            lifePhotoId: String,
            url: String,
            position: Int
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
                lifePhotoId: lifePhotoId,
                position: position
            )
            guard statusCode == 200 else { throw FCError.LifePhoto.updateLifePhotoFailed }
            self.state = .complete
        }
        
        public func setToMainOnTap(
            sourceLifePhotoId: String,
            targetLifePhotoId: String,
            fromPosition: Int
        ) async throws {
            self.state = .loading
            let statusCode = try await MediaService.setMainLifePhoto(
                userId: self.userId,
                sourceLifePhotoId: sourceLifePhotoId,
                targetLifePhotoId: targetLifePhotoId,
                fromPosition: fromPosition
            )
            guard statusCode == 200 else { throw FCError.LifePhoto.updateLifePhotoFailed }
            self.state = .complete
        }
        
        public func showAlert() {
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
        }
    }
    
}
