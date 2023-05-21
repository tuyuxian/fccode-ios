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

    @StateObject var countrySelectionList = CountrySelectionList(countrySelections: [CountryModel]())
    /// Flag for button tappable
    @State private var isStatisfied: Bool = false
    /// Flag for loading state
    @State private var isLoading: Bool = false
    
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
                        countrySelectionList: countrySelectionList,
                        isPreference: false
                    )
                    .onChange(of: countrySelectionList.countrySelections) { _ in
                        vm.nationality = countrySelectionList.countrySelections
                        isStatisfied =
                            vm.nationality.count > 0 &&
                            vm.nationality.count <= 3
                    }
                    
                    InputHelper(
                        isSatisfied: $isStatisfied,
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
                    isTappable: $isStatisfied,
                    isLoading: $isLoading
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
