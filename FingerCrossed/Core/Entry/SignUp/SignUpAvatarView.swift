//
//  SignUpAvatarView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAvatarView: View {
    @ObservedObject var user: EntryViewModel
    @State var selectedImage: UIImage?
    @State var selectedImageData: Data? = nil
    @State var showImagePicker: Bool = false
    @State var showCamera: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                SignUpProcessBar(status: 6)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Upload your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Profile Picture")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)
                
                
                ZStack (alignment: .bottom){
                    
                    if ((self.selectedImage) != nil) {
                        Image(uiImage: self.selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 192, height: 192)
                            .cornerRadius(100)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 12)
                                    .frame(width: 192)
                            )                    }
                    else {
                        Image("ProfilePicture")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 192, height: 192)
                    }
                    
                    
                    
                    HStack (spacing: 112){
                        Button {
                            print("camera")
                            showCamera.toggle()
                        } label: {
                            Image("CameraBased")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(IconButtonWithBackground())
                        
                        Button {
                            showImagePicker.toggle()
                            print("\(user.username)")
                        } label: {
                            Image("PictureBased")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(IconButtonWithBackground())
                    }
                    .padding(.bottom, 6)
                }
                .padding(.vertical, 47)
                .fullScreenCover(isPresented: $showCamera, content: {
                    ImagePicker(sourceType: .camera, selectedImage: self.$selectedImage, imageData: self.$selectedImageData)
                        .edgesIgnoringSafeArea(.all)
                })
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage, imageData: self.$selectedImageData)
                })
                
                Spacer()
                
                Button {
                    self.selectedImage != nil ? user.isQualified = true : nil
                } label: {
                    Text(self.selectedImage != nil ? "Done!": "Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: self.selectedImage != nil ? Color.text : Color.white, buttonColor: self.selectedImage != nil ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
//                NavigationLink (destination: PairingView(candidateList: [CandidateModel]()) //TODO(Lawrence): change to pairing instruction view
//                    .navigationBarBackButtonHidden(true)
//                    .navigationBarItems(
//                        leading:
//                            VStack(alignment: .center) {
//                                NavigationBarBackButton()
//                            }
//                            .frame(height: 40)
//                            .padding(.top, 24)
//                            .padding(.leading, 14)
//                    )) {
//                        Text(self.selectedImage != nil ? "Done!": "Continue")
//                }
//                .buttonStyle(PrimaryButton())
//                .padding(.horizontal, 24)
//                .padding(.bottom, 50)
            }
            .navigationDestination(isPresented: $user.isQualified) {
                PairingView(candidateList: [CandidateModel]()) //TODO(Lawrence): change to pairing instruction view
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    VStack(alignment: .center) {
                        NavigationBarBackButton()
                    }
                    .frame(height: 40)
                    .padding(.top, 24)
                    .padding(.leading, 14))
        }

    }
}

struct SignUpAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAvatarView(user: EntryViewModel())
    }
}
