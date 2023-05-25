//
//  SignUpBirthdayView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpBirthdayView: View {
    /// Observed entry view model
    @ObservedObject var vm: EntryViewModel
    /// Handler for button on tap
    private func buttonOnTap() {
        vm.transition = .forward
        vm.switchView = .gender
    }
    /// Convert single digit to two digit (e.g. 1 to 01)
    private func toTwoDigit(
        index: Int
    ) -> String {
        return index + 1 < 10 ? "0\(index + 1)" : "\(index + 1)"
    }
    /// Convert seleted data to timestamp
    private func getSelectedDate() {
        let currentYear = Calendar.current.component(.year, from: Date())
        // swiftlint:disable line_length
        vm.dateOfBirth = "\(currentYear - (100 - Int(toTwoDigit(index: vm.yearIndex))!))-\(toTwoDigit(index: vm.monthIndex))-\(toTwoDigit(index: vm.dayIndex))T00:00:00Z"
        
        let selectedString = "0\(toTwoDigit(index: vm.dayIndex))/0\(toTwoDigit(index: vm.monthIndex))/\(currentYear - (100 - Int(toTwoDigit(index: vm.yearIndex))!))"
        // swiftlint:enable line_length

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yy"
        
        let selectedDate = dateFormater.date(from: selectedString)!
        
        let yearGap = Calendar.current.dateComponents([.year], from: selectedDate, to: Date.now)
        
        vm.isAdult = yearGap.year! >= 18
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
                        vm.switchView = .name
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
                    
                    Text("Birthday")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .frame(height: 50)
                }
                
                DatePicker(
                    monthIndex: $vm.monthIndex,
                    dayIndex: $vm.dayIndex,
                    yearIndex: $vm.yearIndex
                )
                .padding(.top, 60)
                .onChange(of: vm.monthIndex) { _ in
                    getSelectedDate()
                }
                .onChange(of: vm.yearIndex) { _ in
                    getSelectedDate()
                }
                .onChange(of: vm.dayIndex) { _ in
                    getSelectedDate()
                }

                InputHelper(
                    isSatisfied: $vm.isAdult,
                    label: "You must be over 18",
                    type: .info
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.top, 10)

                Spacer()
                
                PrimaryButton(
                    label: "Continue",
                    action: buttonOnTap,
                    isTappable: $vm.isAdult,
                    isLoading: .constant(false)
                )
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct SignUpBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdayView(
            vm: EntryViewModel()
        )
    }
}
