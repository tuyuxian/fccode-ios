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
    /// Flag for alert
    @State private var showAlert: Bool = false
    /// Handler for button on tap
    private func buttonOnTap() {
        self.endTextEditing()
        vm.transition = .forward
        vm.switchView = .birthday
    }
    /// Check if the user name follow below rules:
    ///  - 2 to 30 characters
    ///  - accept only numbers, spaces, and letters
    ///  - at least 1 letters
    private func check(
        _ str: String
    ) -> Bool {
        let usernameRegEx = "^(?=.*[\\p{L}])(?=.{2,30}$)[\\p{L}\\p{N}\\s]+$"
        let regex = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        let isValid = regex.evaluate(with: str)

        if isValid {
            return true
        } else {
            return false
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
                        showAlert.toggle()
                    } label: {
                        Image("ArrowLeft")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, -8) // 16 - 24
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(
                                "Notice!"
                            )
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .medium
                                )
                            ),
                            message: Text(
                                "Once you go back to the previous page, you will lose all sign up process."
                            ),
                            primaryButton: .destructive(
                                Text("Yes"),
                                action: {
                                    vm.reinit()
                                    vm.transition = .backward
                                    vm.switchView = .email
                                }
                            ),
                            secondaryButton: .cancel(
                                Text("No")
                            )
                        )
                    }
                    
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
                        value: $vm.user.username,
                        hint: "Enter your name",
                        isValid: .constant(true)
                    )
                    .onChange(of: vm.user.username) { name in
                        vm.user.username = String(name.prefix(30))
                        vm.isNameSatisfied = check(vm.user.username)
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
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.16)) {
                UIApplication.shared.closeKeyboard()
            }
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
