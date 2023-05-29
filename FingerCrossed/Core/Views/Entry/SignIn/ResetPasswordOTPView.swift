//
//  ResetPasswordOTPView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/23/23.
//

import SwiftUI

struct ResetPasswordOTPView: View {
    /// Global banner
    @EnvironmentObject var bm: BannerManager
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Flag for loading state
    @State private var isLoading: Bool = false
    /// One time password
    @State private var otp: String = ""
    /// Time for count down usage
    @State private var timeRemaining = 60
    /// Flag for otp validation
    @State private var isOTPValid: Bool = true
    /// Flag for button tappable
    @State private var isOTPSatisfied: Bool = false
    /// Flag for keyboard signal
    @FocusState private var isKeyboardShowUp: Bool
    /// Time ticker
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()
    /// Handler for button on tap
    private func buttonOnTap() {
        isLoading.toggle()
        Task {
            do {
                let valid = try await EntryRepository.verifyOTP(
                    email: vm.user.email,
                    userOTP: otp
                )
                guard valid else {
                    isLoading.toggle()
                    isOTPValid = false
                    return
                }
                isLoading.toggle()
                self.endTextEditing()
                vm.transition = .forward
                vm.switchView = .resetPassword
            } catch {
                print(error.localizedDescription)
                bm.pop(
                    title: "Something went wrong.",
                    type: .error
                )
            }
        }
    }
    /// Handler for resend
    private func resendOnTap() {
        isLoading.toggle()
        Task {
            do {
                let success = try await EntryRepository.requestOTP(
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
    
    @ViewBuilder
    private func OTPTextField(
        _ index: Int,
        _ isValid: Bool
    ) -> some View {
        ZStack {
            if otp.count > index {
                let startIndex = otp.startIndex
                let charIndex = otp.index(startIndex, offsetBy: index)
                let charToString = String(otp[charIndex])
                Text(charToString)
                    .fontTemplate(.h1Medium)
                    .foregroundColor(Color.text)
            } else {
                Text(" ")
            }
        }
        .frame(width: 40, height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    isValid
                    ? otp.count == index
                        ? Color.text
                        : Color.surface2
                    : Color.warning
                )
                .frame(
                    width: 40,
                    height: 2
                ),
            alignment: .bottom
        )
        .frame(maxWidth: .infinity)
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
                        vm.switchView = .resetPasswordEmailCheck
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
                
                VStack(spacing: 74) {
                    Text("Enter verification code")
                        .fontTemplate(.h2Bold)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.center)
                        .frame(height: 42)
                    
                    HStack(spacing: 20) {
                        ForEach(0..<6, id: \.self) { index in
                            OTPTextField(
                                index,
                                isOTPValid
                            )
                        }
                    }
                    .background {
                        TextField("", text: $otp.prefix(6))
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .frame(width: 1, height: 1)
                            .opacity(0)
                            .blendMode(.screen)
                            .focused($isKeyboardShowUp)
                    }
                    .contentShape(Rectangle())
                    .onChange(of: otp) { _ in
                        isOTPValid = true
                        isOTPSatisfied = isOTPValid && otp.count == 6
                    }
                }
                
                isOTPValid
                ? nil
                : HStack(
                    alignment: .top,
                    spacing: 6.0
                ) {
                    Image("Error")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 16,
                            height: 16
                        )
                    Text("Hmm, that's not the right verification code.")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.warning)
                }
                .padding(.top, 10)
                
                HStack(spacing: 12) {
                    Button {
                        resendOnTap()
                        timeRemaining = 60
                    } label: {
                        Text("Resend code")
                            .fontTemplate(.noteMedium)
                            .foregroundColor(
                                timeRemaining > 0
                                ? Color.textHelper
                                : Color.text)
                            .underline(
                                true,
                                color: timeRemaining > 0
                                ? Color.textHelper
                                : Color.text
                            )
                    }
                    .disabled(timeRemaining > 0)
                    
                    timeRemaining > 0
                    ? Text("\(timeRemaining)s")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.textHelper)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                        }
                    : nil
                }
                .padding(.top, 30)
                
                Spacer()
                
                PrimaryButton(
                    label: "Verify",
                    action: buttonOnTap,
                    isTappable: $isOTPSatisfied,
                    isLoading: $isLoading
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            isKeyboardShowUp = true
        }
    }
}

struct ResetPasswordOTPView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordOTPView(
            vm: EntryViewModel()
        )
    }
}

/// Binding prefix extension
extension Binding where Value == String {
    func prefix(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(
                    self.wrappedValue.prefix(length)
                )
            }
        }
        return self
    }
}
