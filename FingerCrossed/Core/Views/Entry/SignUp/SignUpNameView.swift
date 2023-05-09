//
//  SignUpNameView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNameView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for name validation
    @State var isSatisfied: Bool = false
    
    private func buttonOnTap() {
        vm.transition = .forward
        vm.switchView = .birthday
    }
    
    private func checkLength(str: String) -> Bool {
        return str.count >= 2 && str.count <= 30
    }
    
    private func checkSymbols(
        str: String
    ) -> Bool {
        let specialCharacterRegEx  = ".*[!&^%$#@()/*+]+.*"
        let symbolChecker = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        guard symbolChecker.evaluate(with: str) else { return false }
        return true
    }
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .center,
                vertical: .top
            )
        ) {
            Color.background.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                VStack(spacing: 0) {
                    SignUpProcessBar(status: 1)
                        .padding(.bottom, 30)
                    
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    
                    Text("Name")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 50)
                }
                
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    PrimaryInputBar(
                        input: .text,
                        value: $vm.name,
                        hint: "Please enter your name"
                    )
                    .onChange(of: vm.name) { name in
                        isSatisfied = checkLength(str: name) &&
                        (vm.checkUpper(str: name) || vm.checkLower(str: name)) &&
                        !checkSymbols(str: name)
                    }
                    
                    VStack {
                        InputHelper(
                            isSatisfied: $isSatisfied,
                            label: "Name should be 2 to 30 characters",
                            type: .info
                        )
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                        .ignoresSafeArea(.keyboard)
                    
                    PrimaryButton(
                        label: "Continue",
                        action: buttonOnTap,
                        isTappable: $isSatisfied
                    )
                    .padding(.bottom, 16)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameView(vm: EntryViewModel())
    }
}
