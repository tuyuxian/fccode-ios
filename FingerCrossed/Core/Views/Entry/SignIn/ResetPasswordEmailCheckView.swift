//
//  ResetPasswordEmailCheckView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ResetPasswordEmailCheckView: View {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        Task {
            do {
                let success = try await GraphAPI.requestOTP(
                    email: vm.user.email
                )
                guard success else {
                    isLoading.toggle()
                    bm.pop(
                        title: "Something went wrong.",
                        type: .error
                    )
                    return
                }
                isLoading.toggle()
                vm.transition = .forward
                vm.switchView = .resetPasswordOTP
            } catch {
                print(error.localizedDescription)
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
            }
        }
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                HStack(
                    alignment: .center,
                    spacing: 92
                ) {
                    Button {
                        vm.user.password = ""
                        vm.transition = .backward
                        vm.switchView = .password
                    } label: {
                        Image("ArrowLeft")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                VStack(
                    alignment: .center,
                    spacing: 0
                ) {
                    Text("Verification code\nwill be sent to\n \(vm.user.email)")
                        .fontTemplate(.h2Bold)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    LottieView(
                        lottieFile: "email.json"
                    )
                    .frame(
                        width: 240,
                        height: 240
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                PrimaryButton(
                    label: "Send Code",
                    action: buttonOnTap,
                    isTappable: .constant(true),
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResetPasswordEmailCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordEmailCheckView(
            vm: EntryViewModel()
        )
    }
}
