//
//  SignUpEthnicityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/21/23.
//

import SwiftUI

struct SignUpEthnicityView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Ethnicity option list
    let ethnicityOptions: [String] = [
        "American Indian",
        "Black/African American",
        "East Asian",
        "Hipanic/Latino",
        "Mid Eastern",
        "Pacific Islander",
        "South Asian",
        "Southeast Asian",
        "White/Caucasian"
    ]
    
    /// Handler for button on tap
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
                        vm.switchView = .gender
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
                
                CheckBoxGroup(
                    items: ethnicityOptions,
                    selectedIdList: Array(
                        vm.user.ethnicity.map { $0.type.getString() }
                    ),
                    callback: { list in
                        vm.user.ethnicity.removeAll()
                        for item in list {
                            vm.user.ethnicity.append(
                                Ethnicity(
                                    type: EthnicityType.allCases.first(where: {
                                        $0.getString() == item
                                    })!
                                )
                            )
                        }
                    }
                )
                .padding(.vertical, 20)
                .onChange(of: vm.user.ethnicity) { _ in
                    vm.isEthnicitySatisfied = vm.user.ethnicity.count > 0
                }
                
                Spacer()

                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isEthnicitySatisfied,
                    isLoading: .constant(false)
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEthnicityView(
            vm: EntryViewModel()
        )
    }
}
