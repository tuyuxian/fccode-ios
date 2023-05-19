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
    
    private func buttonOnTap() {
        vm.transition = .backward
        vm.switchView = .email
        vm.email = ""
        vm.isEmailSatisfied = false
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
