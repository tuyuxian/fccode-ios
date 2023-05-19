//
//  DatePicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/1/23.
//

import SwiftUI

struct DatePicker: View {
    @Binding var monthIndex: Int
    @Binding var dayIndex: Int
    @Binding var yearIndex: Int
    
    @State var month: [String] = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "Sepetember",
        "Octobor",
        "November",
        "December"
    ]
    @State var dayCount: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    @State var day: [Int] = []
    @State var year: [String] = []
    
    var body: some View {
        LazyVStack {
            ZStack {
                Rectangle()
                    .fill(Color.yellow20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .cornerRadius(16)
                
                HStack {
                    GeometryReader { geometry in
                        HStack {
                            CustomPicker(
                                $monthIndex,
                                items: $month
                            ) { value in
                                GeometryReader { reader in
                                    Text("\(value)")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.text)
                                        .frame(
                                            width: reader.size.width,
                                            height: reader.size.height,
                                            alignment: .center
                                        )
                                }
                            }
                            .scrollAlpha(0.25)
                            .frame(
                                width: 120,
                                height: geometry.size.height,
                                alignment: .center
                            )
                            .onChange(of: monthIndex) { val in
                                if dayIndex > dayCount[val] - 1 {
                                    dayIndex = dayCount[val] - 1
                                }
                                day = Array(1...dayCount[val])
                            }
                            
                            Spacer()
                            
                            CustomPicker(
                                $dayIndex,
                                items: $day
                            ) { value in
                                GeometryReader { reader in
                                    Text("\(value)")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.text)
                                        .frame(
                                            width: reader.size.width,
                                            height: reader.size.height,
                                            alignment: .center
                                        )
                                }
                            }
                            .scrollAlpha(0.25)
                            .frame(
                                width: 90,
                                height: geometry.size.height,
                                alignment: .center
                            )
                            .onAppear {
                                let year = Int(year[yearIndex]) ?? 0
                                switch (year % 4 == 0, year % 100 == 0, year % 400 == 0) {
                                case (true, false, _), (true, true, true):
                                    self.dayCount[1] = 29
                                    self.day = Array(1...dayCount[monthIndex])
                                default:
                                    self.dayCount[1] = 28
                                    self.day = Array(1...dayCount[monthIndex])
                                }
                            }
                            
                            Spacer()
                            
                            CustomPicker(
                                $yearIndex,
                                items: $year
                            ) { value in
                                GeometryReader { reader in
                                    Text("\(value)")
                                        .fontTemplate(.pMedium)
                                        .foregroundColor(Color.text)
                                        .frame(
                                            width: reader.size.width,
                                            height: reader.size.height,
                                            alignment: .center
                                        )
                                }
                            }
                            .scrollAlpha(0.25)
                            .frame(
                                width: 90,
                                height: geometry.size.height,
                                alignment: .center
                            )
                            .onChange(of: yearIndex) { val in
                                let year = Int(year[val]) ?? 0
                                switch (year % 4 == 0, year % 100 == 0, year % 400 == 0) {
                                case (true, false, _), (true, true, true):
                                    self.dayCount[1] = 29
                                    self.day = Array(1...dayCount[monthIndex])
                                    if dayIndex > dayCount[monthIndex] - 1 {
                                        dayIndex = dayCount[monthIndex] - 1
                                    }
                                default:
                                    self.dayCount[1] = 28
                                    self.day = Array(1...dayCount[monthIndex])
                                    if dayIndex > dayCount[monthIndex] - 1 {
                                        dayIndex = dayCount[monthIndex] - 1
                                    }
                                }
                            }
                            .onAppear {
                                self.year = Array(
                                    stride(
                                        from: Calendar.current.component(.year, from: Date()) - 99,
                                        through: Calendar.current.component(.year, from: Date()),
                                        by: 1
                                    )
                                ).map { String($0) }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                }
                
            }
        }
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker(
            monthIndex: .constant(0),
            dayIndex: .constant(0),
            yearIndex: .constant(0)
        )
        .padding(.horizontal, 24)
    }
}
