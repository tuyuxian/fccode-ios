//
//  LifePhotoActionModal.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoActionModal: View {
    
    @Binding var isShowing: Bool
    var body: some View {
        isShowing
        ? withAnimation(.easeInOut)  {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing = false
                        }
                    VStack(spacing: 0) {
                        VStack(spacing: 20){
                            HStack(alignment: .center) {
                                Text("Life Photos")
                                    .fontTemplate(.h2Medium)
                                    .foregroundColor(Color.text)
                            }
                            HStack(spacing: 91) {
                                Button {
                                    // TODO(Sam): add action for life photo
                                } label: {
                                    Image("CameraBased")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 56, height: 56)
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.orange100)
                                .cornerRadius(50)
                                
                                Button {
                                    // TODO(Sam): add action for life photo
                                } label: {
                                    Image("PictureBased")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 56, height: 56)
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.orange100)
                                .cornerRadius(50)
                            }
                        }
                        .frame(height: 134)
                        .padding(EdgeInsets(top: 0, leading: 36, bottom: 55, trailing: 36))
                        
                    }
                    .frame(height: 258)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .transition(.move(edge: .bottom))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        : nil
    }
}

struct LifePhotoActionModal_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoActionModal(isShowing: .constant(true))
    }
}
