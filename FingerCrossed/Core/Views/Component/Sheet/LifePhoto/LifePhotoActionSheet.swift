//
//  LifePhotoActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI
import PhotosUI

struct LifePhotoActionSheet: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    @State var showEditSheet: Bool = false
        
    @State var showCamera: Bool = false
    
    @State var showCameraAlert: Bool = false
    
    @State var showImagePicker: Bool = false
    
    @State var showPhotoLibraryAlert: Bool = false
    
    let photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    
    let cameraPermissionManager = CameraPermissionManager()

    private func takePhotosOnTap() {
        switch cameraPermissionManager.permissionStatus {
        case .notDetermined:
            cameraPermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                showCamera = true
            }
        case .denied:
            showCameraAlert.toggle()
        default:
            showCamera = true
        }
    }
    
    private func uploadPhotosOnTap() {
        switch photoLibraryPermissionManager.permissionStatus {
        case .notDetermined:
            photoLibraryPermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                showImagePicker = true
            }
        case .denied:
            showPhotoLibraryAlert.toggle()
        default:
            showImagePicker = true
        }
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 30
            ) {
                if vm.hasLifePhoto {
                    Button {
                        // TODO(Sam): add delete method
                    } label: {
                        LifePhotoActionRow(actionType: .delete)
                    }
                    
                    Button {
                        showEditSheet = true
                    } label: {
                        LifePhotoActionRow(actionType: .edit)
                    }
                } else {
                    Button {
                        takePhotosOnTap()
                    } label: {
                        LifePhotoActionRow(actionType: .camera)
                    }
                    .fullScreenCover(
                        isPresented: $showCamera,
                        onDismiss: {
                            guard vm.selectedImage != nil else { return }
                            showEditSheet = true
                        },
                        content: {
                            ImagePicker(
                                sourceType: .camera,
                                selectedImage: $vm.selectedImage,
                                imageData: $vm.selectedImageData
                            )
                            .edgesIgnoringSafeArea(.all)
                        }
                    )
                    .alert(isPresented: $showCameraAlert) {
                        Alert(
                            title:
                                Text(cameraPermissionManager.alertTitle)
                                .font(Font.system(size: 18, weight: .medium)),
                            message:
                                Text(cameraPermissionManager.alertMessage)
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
                        uploadPhotosOnTap()
                    } label: {
                        LifePhotoActionRow(actionType: .photo)
                    }
                    .sheet(
                        isPresented: $showImagePicker,
                        onDismiss: {
                            guard vm.selectedImage != nil else { return }
                            showEditSheet = true
                        },
                        content: {
                            ImagePicker(
                                sourceType: .photoLibrary,
                                selectedImage: $vm.selectedImage,
                                imageData: $vm.selectedImageData
                            )
                        }
                    )
                    .alert(isPresented: $showPhotoLibraryAlert) {
                        Alert(
                            title:
                                Text(photoLibraryPermissionManager.alertTitle)
                                .font(Font.system(size: 18, weight: .medium)),
                            message:
                                Text(photoLibraryPermissionManager.alertMessage)
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
            .padding(.horizontal, 24)
            .padding(.top, 30)
            .background(Color.white)
            .presentationDetents([.height(138)])
            .presentationDragIndicator(.visible)
        }
        .sheet(
            isPresented: $showEditSheet,
            onDismiss: {
                vm.selectedImage = nil
            },
            content: {
                LifePhotoEditSheet(
                    vm: vm,
                    text: vm.selectedLifePhoto?.caption ?? ""
                )
            }
        )
    }
}

struct LifePhotoActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoActionSheet(
            vm: ProfileViewModel()
        )
    }
}

private struct LifePhotoActionRow: View {
    
    enum ActionType {
        case camera
        case delete
        case edit
        case photo
    }
    
    @State var actionType: ActionType
    
    var body: some View {
        HStack(spacing: 20) {
            switch actionType {
            case .camera:
                Image("Camera")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Take Photos")
                    .fontTemplate(.h3Medium)
                    .foregroundColor(Color.text)
                Spacer()
            case .delete:
                Image("Trash")
                    .resizable()
                    .frame(width: 24, height: 24)

                Text("Delete")
                    .fontTemplate(.h3Medium)
                    .foregroundColor(Color.text)
                Spacer()
            case .edit:
                Image("Edit")
                    .resizable()
                    .frame(width: 24, height: 24)

                Text("Edit Photo")
                    .fontTemplate(.h3Medium)
                    .foregroundColor(Color.text)
                Spacer()
            case .photo:
                Image("Picture")
                    .resizable()
                    .frame(width: 24, height: 24)

                Text("Upload Photos")
                    .fontTemplate(.h3Medium)
                    .foregroundColor(Color.text)
                Spacer()
                
            }
        }
    }
}
