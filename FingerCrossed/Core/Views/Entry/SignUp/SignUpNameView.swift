//
//  SignUpNameView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNameView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Handler for button on tap
    private func buttonOnTap() {
        self.endTextEditing()
        vm.transition = .forward
        vm.switchView = .birthday
    }
    /// Check if the string is between 2 to 30 characters
    private func checkLength(
        str: String
    ) -> Bool {
        return str.count >= 2 && str.count <= 30
    }
    /// Check if the string contains any characters
    private func checkCharacter(
        str: String
    ) -> Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return !CharacterSet(charactersIn: str).isSubset(of: digitsCharacters)
    }
    /// Check if the string contains any special characters
    private func checkSymbols(
        str: String
    ) -> Bool {
        let specialCharacterRegEx  = ".*[!&^%$#@()/*+_]+.*"
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
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                HStack(
                    alignment: .center,
                    spacing: 92
                ) {
                    Button {
                        vm.transition = .backward
                        vm.switchView = .account
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
                        hint: "Enter your name",
                        isValid: .constant(true)
                    )
                    .onChange(of: vm.name) { name in
                        vm.name = String(name.prefix(30))
                        vm.isNameSatisfied =
                            checkLength(str: name) &&
                            checkCharacter(str: name) &&
                            !checkSymbols(str: name)
                    }
                    
                    VStack {
                        InputHelper(
                            isSatisfied: $vm.isNameSatisfied,
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
                        isTappable: $vm.isNameSatisfied,
                        isLoading: .constant(false)
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
        SignUpNameView(
            vm: EntryViewModel()
        )
    }
}
