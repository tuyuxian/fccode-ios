//
//  SignUpAvatarView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAvatarView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    @State var selectedImage: UIImage?
    @State var selectedImageData: Data?
    // Flag for image picker's signal
    @State var showImagePicker: Bool = false
    // Flag for camera's signal
    @State var showCamera: Bool = false
    // Flag for button tappable
    @State var isStatisfied: Bool = false
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                EntryLogo()
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
                
                ZStack(alignment: .bottom) {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
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
                .padding(.top, 20)
                .fullScreenCover(
                    isPresented: $showCamera,
                    content: {
                        ImagePicker(
                            sourceType: .camera,
                            selectedImage: $selectedImage,
                            imageData: $selectedImageData
                        )
                        .edgesIgnoringSafeArea(.all)
                    }
                )
                .sheet(
                    isPresented: $showImagePicker,
                    content: {
                        ImagePicker(
                            sourceType: .photoLibrary,
                            selectedImage: $selectedImage,
                            imageData: $selectedImageData
                        )
                    }
                )
                
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    isTappable: $isStatisfied
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .onChange(of: selectedImage) { _ in
                isStatisfied = selectedImage != nil
            }
        }
    }
}

struct SignUpAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAvatarView(vm: EntryViewModel())
    }
}
