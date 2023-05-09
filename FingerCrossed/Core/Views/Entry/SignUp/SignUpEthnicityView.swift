//
//  SignUpEthnicityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/21/23.
//

import SwiftUI

struct SignUpEthnicityView: View {
    // Observed entry view model
    @ObservedObject var vm: EntryViewModel
    // Flag for name validation
    @State var isSatisfied: Bool = false
    
    private func buttonOnTap() {
        vm.transition = .forward
        vm.switchView = .nationality
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
                    SignUpProcessBar(status: 4)
                        .padding(.bottom, 30)
                    
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 24)
                    
                    Text("Ethnicity")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 50)
                }
                
                CheckBoxEthnicityGroup(ethnicityList: $vm.ethnicity) { _ in
                }
                .padding(.vertical, 20)
                .onChange(of: vm.ethnicity) { _ in
                    isSatisfied = vm.ethnicity.count > 0
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

struct SignUpEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEthnicityView(vm: EntryViewModel())
    }
}
