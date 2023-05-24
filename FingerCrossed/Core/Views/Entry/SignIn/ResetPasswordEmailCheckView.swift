//
//  ResetPasswordEmailCheckView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ResetPasswordEmailCheckView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        // TODO(Sam): send email
        vm.transition = .forward
        vm.switchView = .resetPasswordOTP
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
                        vm.password = ""
                        vm.transition = .backward
                        vm.switchView = .password
                    } label: {
                        Image("ArrowLeftBased")
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
                    Text("A verification code will be sent to \(vm.email).")
                        .fontTemplate(.bigBoldTitle)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                    
                    LottieView(
                        lottieFile: "email.json"
                    )
                    .frame(
                        width: 300,
                        height: 300
                    )
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
