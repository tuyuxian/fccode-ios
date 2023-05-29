//
//  SettingsSocialAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsSocialAccountView: View {
    
    @ObservedObject var vm: ProfileViewModel
    @State var deleteAlert: Bool = false
    @State var signOutAlert: Bool = false
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Settings",
            childTitle: "Account",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            Box {
                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {
                    SocialAccountRow(
                        label: "Facebook",
                        isConnected: vm.user.facebookConnect
                    )
                    
                    Divider()
                        .overlay(Color.surface3)
                    
                    SocialAccountRow(
                        label: "Google",
                        isConnected: vm.user.googleConnect
                    )
                    
                    Divider()
                        .overlay(Color.surface3)
                   
                    SocialAccountRow(
                        label: "Apple",
                        isConnected: vm.user.appleConnect
                    )
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                
                Divider()
                    .overlay(Color.surface2)
                    .padding(.horizontal, 24)
                
                VStack(
                    spacing: 16
                ) {
                    Button {
                        // Log out
                        signOutAlert = true
                    } label: {
                        Text("Sign out")
                            .foregroundColor(Color.text)
                            .fontTemplate(.pMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .alert("Do you really want to Sign out?", isPresented: $signOutAlert, actions: {
                        Button(role: .cancel, action: {}) {
                            Text("No")
                                .foregroundColor(Color.text)
                                .fontTemplate(.h3Medium)
                        }
                        
                        Button(role: .destructive, action: {}) {
                            Text("Yes")
                                .foregroundColor(Color.warning)
                                .fontTemplate(.h3Medium)
                        }
                    }, message: {
                        Text("Please noted that once you delete your account, it can no longer be retrieved. ")
                    })
                    
                    Button {
                        // Delete account
                        deleteAlert = true
                    } label: {
                        Text("Delete account")
                            .foregroundColor(Color.warning)
                            .fontTemplate(.pMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .alert("Do you really want to delete account?", isPresented: $deleteAlert, actions: {
                        Button(action: {}) {
                            Text("No")
                                .foregroundColor(Color.text)
                                .fontTemplate(.h3Medium)
                        }
                        
                        Button(action: {}) {
                            Text("Yes")
                                .foregroundColor(Color.warning)
                                .fontTemplate(.h3Medium)
                        }
                    }, message: {
                        Text("Please noted that once you delete your account, it can no longer be retrieved. ")
                    })
                }
                .padding(.vertical, 30)
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
                .fontTemplate(.pMedium)
                .foregroundColor(.text)
            
            Spacer()
            
            Button(isConnected ? "Connected" : "Connect") {
                // TODO(Sam): add connect method
                GoogleSSOManager().disconnect()
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
