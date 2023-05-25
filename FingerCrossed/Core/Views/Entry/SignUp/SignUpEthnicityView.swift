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
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
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
                    selectedIdList: Array(vm.ethnicity.map { $0.type.rawValue }),
                    ethnicityList: $vm.ethnicity,
                    callback: { _ in }
                )
                .padding(.vertical, 20)
                .onChange(of: vm.ethnicity) { _ in
                    vm.isEthnicitySatisfied = vm.ethnicity.count > 0
                }
                
                Spacer()

                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isEthnicitySatisfied,
                    isLoading: $isLoading
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
