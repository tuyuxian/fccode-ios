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
    
    private func upload(
        _ data: Data?,
        toPresignedURL remoteURL: URL
    ) async -> Result<URL?, Error> {
        return await withCheckedContinuation { continuation in
            AWSS3.upload(data, toPresignedURL: remoteURL) { (result) in
                switch result {
                case .success(let url):
                    print("File uploaded: ", url!)
                case .failure(let error):
                    print("Upload failed: ", error.localizedDescription)
                }
                continuation.resume(returning: result)
            }
        }
    }
    
    private func buttonOnTap() {
        Task {
            do {
                let result = await upload(
                    vm.selectedImageData,
                    // TODO(Sam): replace with presigned Url generated from backend
                    // swiftlint: disable line_length
                    toPresignedURL: URL(string: "https://fc-development.s3.us-west-1.amazonaws.com/test.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAV3WQQ3NAMASFS5L2%2F20230511%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20230511T225520Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&x-id=PutObject&X-Amz-Signature=d7b821923dcedf96f7ef196dcfb911adc1ce1f905778dc53a1dd6e390dac9c50")!
                    // swiftlint: enable line_length

                )
                print("Result: \(result)")
            }
//            catch {
//                print(error)
//            }
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
                            showCamera.toggle()
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
                        
                        Button {
                            showImagePicker.toggle()
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
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width - 48)
                .padding(.top, 20)
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
                )
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
