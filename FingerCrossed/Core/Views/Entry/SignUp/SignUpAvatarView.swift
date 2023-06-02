//
//  SignUpAvatarView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI
import GraphQLAPI
import Photos

struct SignUpAvatarView: View {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for image picker's signal
    @State private var showImagePicker: Bool = false
    /// Flag for camera's signal
    @State private var showCamera: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Flag for camera permission alert
    @State var showCameraAlert: Bool = false
    /// Flag for photo library permission alert
    @State var showPhotoLibraryAlert: Bool = false
    /// Init photo library permission manager
    let photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    /// Init camera permission manager
    let cameraPermissionManager = CameraPermissionManager()
    /// Handler for camera on tap
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
    /// Handler for photo library on tap
    private func photoLibraryOnTap() {
        switch photoLibraryPermissionManager.permissionStatus {
        case .notDetermined:
//            photoLibraryPermissionManager.requestPermission { granted, _ in
//                guard granted else { return }
//                showImagePicker = true
//            }
            photoLibraryPermissionManager.requestPermission { photoAuthStatus in
                if photoAuthStatus.isAllowed {
                    showImagePicker = true
                }
            }
        case .limited:
            DispatchQueue.main.async {
                if let window =
                    UIApplication.shared.windows.first {
                    PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: window.rootViewController!)
                }
            }
        case .authorized:
            photoLibraryPermissionManager.requestPermission { photoAuthStatus in
                if photoAuthStatus.isAllowed {
                    showImagePicker = true
                }
            }
        case .denied:
            showPhotoLibraryAlert.toggle()
        default:
            showImagePicker = false
        }
    }
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        Task {
            do {
                let url = try await MediaRepository.getPresignedPutUrl(
                    GraphQLEnum.case(.image)
                )
                let result = try await AWSS3().uploadImage(
                    vm.selectedImageData,
                    toPresignedURL: URL(string: url!)!
                )
                vm.user.profilePictureUrl = result.absoluteString
                vm.user.lifePhoto.append(
                    LifePhoto(
                        contentUrl: result.absoluteString,
                        caption: "",
                        position: 0,
                        scale: 1,
                        offset: CGSize.zero
                    )
                )
                isLoading.toggle()
                vm.transition = .forward
                vm.switchView = .location
                
            } catch {
                print(error.localizedDescription)
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
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
                        Image("ArrowLeft")
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
                                    Image("Camera")
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
                            photoLibraryOnTap()
                        } label: {
                            Circle()
                                .fill(Color.yellow100)
                                .frame(
                                    width: 54,
                                    height: 54
                                )
                                .overlay(
                                    Image("Picture")
                                        .renderingMode(.template)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.white)
                                        .frame(width: 36, height: 36)
                                )
                        }
//                        .sheet(
//                            isPresented: $showImagePicker,
//                            content: {
//                                ImagePicker(
//                                    sourceType: .photoLibrary,
//                                    selectedImage: $vm.selectedImage,
//                                    imageData: $vm.selectedImageData
//                                )
//                            }
//                        )
                        .sheet(isPresented: $showImagePicker) {
                            PhotoPicker(selectedImage: $vm.selectedImage,
                                        imageData: $vm.selectedImageData,
                                        isPresented: $showImagePicker)
                        }
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
