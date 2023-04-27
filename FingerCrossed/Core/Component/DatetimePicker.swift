//
//  DatetimePicker.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct DatetimePicker: View {
    @State private var firstPickerSelection = 1
    @State private var secondPickerSelection = 1
    @State private var thirdPickerSelection = 1
    
    let numbers = Array(1...30)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.918, green: 0.918, blue: 0.925))
                .frame(height: 30)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Picker("", selection: $firstPickerSelection) {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .frame(width: 80)
                .pickerStyle(.wheel)
                
                Picker("", selection: $secondPickerSelection) {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                            .frame(height: 100)
                    }
                }
                .frame(width: 80)
                .pickerStyle(.wheel)
                
                Picker("", selection: $thirdPickerSelection) {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .frame(width: 80)
                .pickerStyle(.wheel)
            }
//                .padding(.leading, CGFloat((firstPickerSelection - 1) * 80 + (secondPickerSelection - 1) * 80 + (thirdPickerSelection - 1) * 80) / 3)
            
        }
    }
}


struct DatetimePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatetimePicker()
    }
}
