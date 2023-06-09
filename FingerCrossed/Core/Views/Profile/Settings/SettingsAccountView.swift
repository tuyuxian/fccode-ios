//
//  SettingsAccountView.swift
//  FingerCrossed
//
//  Created by Kevin Tsai on 4/10/23.
//

import SwiftUI

struct SettingsAccountView: View {
    /// Observed settings account view model
    @StateObject var vm: SettingsAccountViewModel
    /// Banner
    @EnvironmentObject var bm: BannerManager
    
    init(
        appleConnect: Bool,
        googleConnect: Bool
    ) {
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
                        vm.signOutOnTap()
                    } label: {
                        Text("Sign out")
                            .foregroundColor(Color.text)
                            .fontTemplate(.pMedium)
                    }
                    
                    Button {
                        vm.deleteAccountOnTap()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(Color.warning)
                            .fontTemplate(.pMedium)
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
            .appAlert($vm.appAlert)
            .overlay {
                vm.state == .loading
                ? PageSpinner()
                : nil
            }
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.errorMessage,
                        type: .error
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
                        print(state)
                        if state == .complete {
                            isConnected.toggle()
                        }
                    }
                }
                .disabled(isConnected)
        }
    }
}
