//
//  SignUpAvatarView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAvatarView: View {
    
    @State var selectedImage: Image?
    @State var showImagePicker: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Upload your...")
                        .fontTemplate(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
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
                .padding(.vertical, 12)
                
                
                ZStack (alignment: .bottom){
                    
                    if ((self.selectedImage) != nil) {
                        self.selectedImage?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 192, height: 192)
                            .cornerRadius(100)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 12)
                                    .frame(width: 192)
                            )
                    }
                    else {
                        Image("ProfilePicture")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 192, height: 192)
                    }
                    
                    
                    
                    HStack (spacing: 112){
                        Button {
                            print("camera")
                        } label: {
                            Image("CameraWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(IconButtonWithBackground())
                        
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            Image("PictureWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 36)
                        }
                        .buttonStyle(IconButtonWithBackground())
                    }
                    .padding(.bottom, 6)
                }
                .padding(.vertical, 47)
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(image: self.$selectedImage)
                })
                
                Spacer()
                    .frame(height: 82)
                
                Button {
                    print("Continue")
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SignUpAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAvatarView()
    }
}
