//
//  SignUpNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNationalityView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Handler for button on tap
    private func buttonOnTap() {
        vm.transition = .forward
        vm.switchView = .avatar
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
                        vm.switchView = .ethnicity
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
                
                VStack(spacing: 0) {
                    SignUpProcessBar(status: 5)
                        .padding(.bottom, 30)
                    
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    
                    Text("Nationality")
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
                    NationalityPicker(
                        nationalityList: $vm.user.citizen,
                        isPreference: false
                    )
                    .onChange(of: vm.user.citizen) { val in
                        vm.isNationalitySatisfied =
                        val.count > 0 &&
                        val.count <= 3
                    }
                    
                    InputHelper(
                        isSatisfied: $vm.isNationalitySatisfied,
                        label: "Up to 3 Nationalities",
                        type: .info
                    )
                    .padding(.leading, 16)
                }
                .padding(.top, 20)
                
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isNationalitySatisfied,
                    isLoading: .constant(false)
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNationalityView(
            vm: EntryViewModel()
        )
    }
}
