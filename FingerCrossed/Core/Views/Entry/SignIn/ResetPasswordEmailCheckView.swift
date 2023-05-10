//
//  ResetPasswordEmailCheckView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/2/23.
//

import SwiftUI

struct ResetPasswordEmailCheckView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    
    private func buttonOnTap() {
        vm.transition = .backward
        vm.switchView = .onboarding
        vm.email = ""
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack(spacing: 0) {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                VStack(spacing: 33) {
                    Text("Please check your email to reset password")
                        .fontTemplate(.bigBoldTitle)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                    
                    Text("✉️")
                        .font(Font.system(size: 160))
                }
                
                Spacer()
                
                PrimaryButton(
                    label: "Back to Login",
                    action: buttonOnTap,
                    isTappable: .constant(true)
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ResetPasswordEmailCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordEmailCheckView(vm: EntryViewModel())
    }
}