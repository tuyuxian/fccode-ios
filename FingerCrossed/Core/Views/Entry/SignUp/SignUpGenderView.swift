//
//  SignUpGenderView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpGenderView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Gender option list
    let genderOptions: [String] = [
        "Male",
        "Female",
        "Transgender",
        "Nonbinary",
        "Prefer not to say"
    ]
    /// Handler for button on tap
    private func buttonOnTap() {
        vm.user.gender = vm.gender!
        vm.transition = .forward
        vm.switchView = .ethnicity
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
                        vm.switchView = .birthday
                    } label: {
                        FCIcon.arrowLeft
                    }
                    .padding(.leading, -8) // 16 - 24
                                        
                    EntryLogo()
                }
                .padding(.top, 5)
                .padding(.bottom, 55)
                
                VStack(spacing: 0) {
                    SignUpProcessBar(status: 3)
                        .padding(.bottom, 30)
                    
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    
                    Text("Gender")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 50)
                }
                
                RadioButtonGroup(
                    items: genderOptions,
                    selectedId: vm.gender?.getString() ?? "",
                    callback: { selected in
                        vm.gender = Gender.allCases.first { gender in
                            gender.getString() == selected
                        }
                    }
                )
                .padding(.vertical, 30)
                .onChange(of: vm.gender) { val in
                    vm.isGenderSatisfied = val != nil
                }
                        
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isGenderSatisfied,
                    isLoading: .constant(false)
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(
            vm: EntryViewModel()
        )
    }
}
