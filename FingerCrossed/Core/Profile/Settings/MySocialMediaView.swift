//
//  SocialAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct MySocialMediaView: View {
    
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Settings", childTitle: "My Social Media") {
            Box {
                VStack(alignment: .leading, spacing: 20.0) {
                    HStack {
                        Text("Facebook")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(.text)
                        
                        Spacer()
                        
                        Button("Connect") {
                            print("Connect!")
                        }
                        .fontTemplate(.pMedium)
                        .padding(EdgeInsets(top: 9, leading: 26, bottom: 9, trailing: 26))
                        .frame(width: 108, height: 38)
                        .background(Color("Orange100"))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                    .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                    
                    Divider()
                    
                    HStack {
                        Text("Google")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(.text)
                        
                        Spacer()
                        
                        Button("Disconnet") {
                            print("Disconnect!")
                        }
                        .fontTemplate(.pMedium)
                        .padding(EdgeInsets(top: 9, leading: 16.5, bottom: 9, trailing: 16.5))
                        .frame(width: 108, height: 38)
                        .foregroundColor(.orange100)
                        .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(Color.orange100, style: StrokeStyle(lineWidth: 1))
                                )
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    Divider()
                    
                    HStack {
                        Text("Apple")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(.text)
                        
                        Spacer()
                        
                        Button("Disconnet") {
                            print("Disconnect!")
                        }
                        .fontTemplate(.pMedium)
                        .padding(EdgeInsets(top: 9, leading: 16.5, bottom: 9, trailing: 16.5))
                        .frame(width: 108, height: 38)
                        .foregroundColor(.orange100)
                        .overlay(
                                    Capsule(style: .continuous)
                                        .stroke(Color.orange100, style: StrokeStyle(lineWidth: 1))
                                )
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    
                    
                }
                
                Spacer()
                TabBar()
            }
            
        }
    }
}

struct SocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MySocialMediaView()
    }
}
