//
//  SettingsSocialAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsSocialAccountView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Settings",
            childTitle: "Social Account"
        ) {
            Box {
                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {
                    SocialAccountRow(
                        label: "Facebook",
                        isConnected: vm.user.facebookConnect!
                    )
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                    
                    SocialAccountRow(
                        label: "Google",
                        isConnected: vm.user.googleConnect!
                    )
                    
                    Divider()
                        .foregroundColor(Color.surface3)
                   
                    SocialAccountRow(
                        label: "Apple",
                        isConnected: vm.user.appleConnect!
                    )
                }
                .padding(.top, 30)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct SettingsSocialAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSocialAccountView(
            vm: ProfileViewModel()
        )
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
                // TODO(Sam): add connect method
                isConnected.toggle()
            }
            .fontTemplate(.pMedium)
            .frame(width: 108, height: 38)
            .foregroundColor(isConnected ? Color.yellow100 : Color.text)
            .background(isConnected ? Color.white : Color.yellow100)
            .clipShape(Capsule())
        }
    }
}
