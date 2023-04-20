//
//  CustomPicker.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/17/23.
//

import SwiftUI

struct CustomPicker: View {
    @State private var birthDate = Date.now

    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
            }
            .datePickerStyle(.wheel)

        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker()
    }
}


struct CustomPickerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .clear
        return pickerView
    }
    
    func updateUIView(_ pickerView: UIPickerView, context: Context) {
        // no-op
    }
}
