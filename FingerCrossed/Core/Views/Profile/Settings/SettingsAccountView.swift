//
//  SettingsAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsAccountView: View {
    /// Observed user state model
    @EnvironmentObject var userState: UserStateViewModel
    /// Observed profile view model
    @ObservedObject var vm: ProfileViewModel
    /// Flag for delete alert
    @State var showDeleteAlert: Bool = false
    /// Flag for sign out alert
    @State var showSignOutAlert: Bool = false
    
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
                    alignment: .leading,
                    spacing: 16
                ) {
                    Button {
                        showSignOutAlert = true
                    } label: {
                        Text("Sign out")
                            .foregroundColor(Color.text)
                            .fontTemplate(.pMedium)
                    }
                    .alert(isPresented: $showSignOutAlert) {
                        Alert(
                            title: Text(
                                "Are you sure you want to sign out?"
                            )
                            .foregroundColor(Color.text)
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .medium
                                )
                            ),
                            primaryButton: .destructive(
                                Text("Yes")
                                    .font(
                                        Font.system(
                                            size: 18,
                                            weight: .medium
                                        )
                                    ),
                                action: {
                                    userState.token = nil
                                    userState.user = nil
                                    userState.isLogin = false
                                    userState.viewState = .onboarding
                                }
                            ),
                            secondaryButton: .cancel(
                                Text("No")
                                    .font(
                                        Font.system(
                                            size: 18,
                                            weight: .medium
                                        )
                                    )
                            )
                        )
                    }
                    
                    Button {
                        showDeleteAlert = true
                    } label: {
                        Text("Delete account")
                            .foregroundColor(Color.warning)
                            .fontTemplate(.pMedium)
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text(
                                "Are you sure you want to sign out?"
                            )
                            .foregroundColor(Color.text)
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .medium
                                )
                            ),
                            message: Text(
                                // swiftlint: disable line_length
                                "Please noted that once you delete your account, you will need to sign up again for our service."
                                // swiftlint: enable line_length
                            )
                            .foregroundColor(Color.text)
                            .font(
                                Font.system(
                                    size: 12,
                                    weight: .medium
                                )
                            ),
                            primaryButton: .destructive(
                                Text("Yes")
                                    .font(
                                        Font.system(
                                            size: 18,
                                            weight: .medium
                                        )
                                    ),
                                action: {
                                    // TODO(Sam): delete account handler
                                }
                            ),
                            secondaryButton: .cancel(
                                Text("No")
                                    .font(
                                        Font.system(
                                            size: 18,
                                            weight: .medium
                                        )
                                    )
                            )
                        )
                    }
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                
                Spacer()
            }
        }
    }
}

struct SettingsAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAccountView(
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
//                GoogleSSOManager().disconnect()
                isConnected.toggle()
            }
            .fontTemplate(.pMedium)
            .frame(width: 108, height: 38)
            .foregroundColor(isConnected ? Color.yellow100 : Color.text)
            .background(isConnected ? Color.white : Color.yellow100)
            .disabled(isConnected)
            .clipShape(Capsule())
        }
    }
}
