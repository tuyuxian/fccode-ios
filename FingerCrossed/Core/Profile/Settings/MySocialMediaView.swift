//
//  MySocialAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct MySocialMediaView: View {
    
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Settings", childTitle: "Social Account") {
            Box {
                VStack(alignment: .leading, spacing: 20.0) {
                    
                    SocialAccountRow(label: "Facebook", isConnected: true)
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    
                    SocialAccountRow(label: "Google", isConnected: false)
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                   
                    SocialAccountRow(label: "Apple", isConnected: false)
                    
                    SocialAccountRow(label: "Facebook", isConnected: true)
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    
                    SocialAccountRow(label: "Google", isConnected: false)
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                   
                    SocialAccountRow(label: "Apple", isConnected: false)
                }
                .padding(.top, 30)
                Spacer()
            }
        }
    }
}

struct SocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MySocialMediaView()
    }
}


struct SocialAccountRow: View {
    @State var label: String
    @State var isConnected: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .fontTemplate(.h3Medium)
                .foregroundColor(.text)
            
            Spacer()
            
            Button(isConnected ? "Disconnect" : "Connect") {
                // TODO(): add connect method
                isConnected.toggle()
            }
            .fontTemplate(.pMedium)
            .frame(width: 108, height: 38)
            .foregroundColor(isConnected ? Color.orange100 : Color.white)
            .background(isConnected ? Color.white : Color.orange100)
            .clipShape(Capsule())
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    }
}
