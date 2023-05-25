//
//  SignUpAvatarView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAvatarView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for image picker's signal
    @State private var showImagePicker: Bool = false
    /// Flag for camera's signal
    @State private var showCamera: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
    @State var showCameraAlert: Bool = false
    
    @State var showPhotoLibraryAlert: Bool = false
    
    let imagePermissionManager = PhotoLibraryPermissionManager()
    
    let cameraPermissionManager = CameraPermissionManager()

    let cameraAlertTitle: String = "Allow camera access in device settings"
    
    let photoLibraryAlertTitle: String = "Allow photos access in device settings"
    // swiftlint: disable line_length
    let cameraAlertMessage: String = "Finger Crossed uses your device's camera so you can take photos"
        
    let photoLibraryAlertMessage: String = "Finger Crossed uses your device's photo library so you can share photos."
    // swiftlint: enable line_length
    
    private func cameraOnTap() {
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
    
    private func photoLibraryOnTap() {
        switch imagePermissionManager.permissionStatus {
        case .notDetermined:
            imagePermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                showImagePicker = true
            }
        case .denied:
            showPhotoLibraryAlert.toggle()
        default:
            showImagePicker = true
        }
    }
    
    private func buttonOnTap() {
        Task {
            do {
                let result = await AWSS3().uploadImage(
                    vm.selectedImageData,
                    // TODO(Sam): replace with presigned Url generated from backend
                    toPresignedURL: URL(string: "")!
                )
                print(result)
            }
        }
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                HStack(
                    alignment: .center,
                    spacing: 92
                ) {
                    Button {
                        vm.transition = .backward
                        vm.switchView = .nationality
                    } label: {
                        Image("ArrowLeftBased")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                VStack(spacing: 0) {
                    SignUpProcessBar(status: 6)
                        .padding(.bottom, 30)
                    
                    Text("Upload your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    
                    Text("Profile Picture")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 50)
                }
                
                ZStack(
                    alignment: Alignment(
                        horizontal: .center,
                        vertical: .bottom
                    )
                ) {
                    if vm.selectedImage != nil {
                        Image(uiImage: vm.selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 182, height: 182)
                            .cornerRadius(100)
                            .overlay(
                                Circle()
                                    .stroke(
                                        Color.white,
                                        lineWidth: 12
                                    )
                                    .frame(width: 194)
                            )
                    } else {
                        Image("ProfilePicture")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 194, height: 194)
                    }
                    
                    HStack(spacing: 112) {
                        Button {
                            cameraOnTap()
                        } label: {
                            Circle()
                                .fill(Color.yellow100)
                                .frame(
                                    width: 54,
                                    height: 54
                                )
                                .overlay(
                                    Image("CameraBased")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.white)
                                        .frame(width: 36, height: 36)
                                )
                        }
                        .fullScreenCover(
                            isPresented: $showCamera,
                            content: {
                                ImagePicker(
                                    sourceType: .camera,
                                    selectedImage: $vm.selectedImage,
                                    imageData: $vm.selectedImageData
                                )
                                .edgesIgnoringSafeArea(.all)
                            }
                        ) .alert(isPresented: $showCameraAlert) {
                            Alert(
                                title:
                                    Text(cameraAlertTitle)
                                    .font(Font.system(size: 18, weight: .medium)),
                                message:
                                    Text(cameraAlertMessage)
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
                            photoLibraryOnTap()
                        } label: {
                            Circle()
                                .fill(Color.yellow100)
                                .frame(
                                    width: 54,
                                    height: 54
                                )
                                .overlay(
                                    Image("PictureBased")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.white)
                                        .frame(width: 36, height: 36)
                                )
                        }
                        .sheet(
                            isPresented: $showImagePicker,
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
                                    Text(photoLibraryAlertTitle)
                                    .font(Font.system(size: 18, weight: .medium)),
                                message:
                                    Text(photoLibraryAlertMessage)
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
                .frame(width: UIScreen.main.bounds.size.width - 48)
                .padding(.top, 20)
                
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isAvatarSatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .onChange(of: vm.selectedImage) { val in
                vm.isAvatarSatisfied = val != nil
            }
        }
    }
}

struct SignUpAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAvatarView(
            vm: EntryViewModel()
        )
    }
}
