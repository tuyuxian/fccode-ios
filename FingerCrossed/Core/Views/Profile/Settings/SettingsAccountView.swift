//
//  SettingsAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsAccountView: View {
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// User state
    @EnvironmentObject var usm: UserStateManager
    /// Init settings account view model
    @StateObject var vm: SettingsAccountViewModel
    
    init(
        appleConnect: Bool,
        googleConnect: Bool
    ) {
        print("[Settings Account] view init")
        _vm = StateObject(
            wrappedValue: SettingsAccountViewModel(
                appleConnect: appleConnect,
                googleConnect: googleConnect
            )
        )
    }
    
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
                        isConnected: vm.googleConnect,
                        action: vm.connectGoogle,
                        state: $vm.state
                    )
                    
                    Divider()
                        .overlay(Color.surface3)
                   
                    SocialAccountRow(
                        label: "Apple",
                        isConnected: vm.appleConnect,
                        action: vm.connectApple,
                        state: $vm.state
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
                        vm.signOutOnTap(action: {
                            usm.token = nil
                            usm.userId = nil
                            usm.isLogin = false
                            usm.viewState = .onboarding
                        })
                    } label: {
                        Text("Sign out")
                            .foregroundColor(Color.text)
                            .fontTemplate(.pMedium)
                    }
                    
                    Button {
                        vm.deleteAccountOnTap(action: {
                            usm.token = nil
                            usm.userId = nil
                            usm.isLogin = false
                            usm.viewState = .onboarding
                        })
                    } label: {
                        Text("Delete account")
                            .foregroundColor(Color.warning)
                            .fontTemplate(.pMedium)
                    }
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .appAlert($vm.appAlert)
            .overlay {
                vm.state == .loading
                ? PageSpinner()
                : nil
            }
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.toastMessage,
                        type: vm.toastType
                    )
                    vm.state = .none
                }
            }
        }
    }
}

struct SettingsAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAccountView(
            appleConnect: false,
            googleConnect: false
        )
        .environmentObject(BannerManager())
        .environmentObject(UserStateManager())
    }
}

struct SocialAccountRow: View {
    
    @State var label: String
    
    @State var isConnected: Bool
    
    @State var action: () async -> Void
    
    @Binding var state: ViewStatus
    
    var body: some View {
        HStack {
            Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(.text)
            
            Spacer()
            
            Text(isConnected ? "Connected" : "Connect")
                .fontTemplate(.pMedium)
                .foregroundColor(isConnected ? Color.yellow100 : Color.text)
                .frame(width: 108, height: 38)
                .background(isConnected ? Color.white : Color.yellow100)
                .cornerRadius(50)
                .contentShape(Rectangle())
                .clipShape(Capsule())
                .onTapGesture {
                    Task {
                        await action()
                        guard state == .complete else { return }
                        isConnected.toggle()
                    }
                }
                .disabled(isConnected)
        }
    }
}