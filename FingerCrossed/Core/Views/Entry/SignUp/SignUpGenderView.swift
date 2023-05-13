//
//  SignUpGenderView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpGenderView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for name validation
    @State var isSatisfied: Bool = false
    
    private func buttonOnTap() {
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
            
            VStack(spacing: 0) {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                VStack(spacing: 0) {
                    SignUpProcessBar(status: 2)
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
                
                RadioButtonGenderGroup { selected in
                    vm.gender = Gender.allCases.first { gender in
                        gender.rawValue == selected
                    }
                }
                .padding(.vertical, 30)
                .onChange(of: vm.gender) { _ in
                    isSatisfied = vm.gender != nil
                }
                        
                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $isSatisfied
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(vm: EntryViewModel())
    }
}
