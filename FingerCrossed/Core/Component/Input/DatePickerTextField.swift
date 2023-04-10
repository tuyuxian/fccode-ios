//
//  DatePickerTextField.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    
    public var placeholder: String
    @Binding public var date: Date?
    
    
    func makeUIView(context: Context) -> UITextField {
        
        let currentDate = Date.now
        let eighteenYearsOld = currentDate.addingTimeInterval(-567993600)
        let hundredYearsOld = currentDate.addingTimeInterval(-3155760000)
        
        let placeholderText = NSAttributedString(string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor(Color.textHelper)])
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = eighteenYearsOld
        datePicker.minimumDate = hundredYearsOld
        datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        
        textField.placeholder = placeholder
        textField.attributedPlaceholder = placeholderText
        textField.inputView = datePicker
        textField.textColor = UIColor(Color.text)
        textField.font = UIFont(name: "Azo-Medium", size: 14)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: helper, action: #selector(helper.doneButtonTapped))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        helper.onDateValueChanged = {
            date = datePicker.date
        }
        
        helper.onDoneButtonTapped = {
            if date == nil {
                date = datePicker.date
            }
            
            textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = dateFormatter().string(from: selectedDate)
        }
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM / dd / yyyy"
        return formatter
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var onDateValueChanged: (() -> Void)?
        public var onDoneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            onDateValueChanged?()
        }
        
        @objc func doneButtonTapped() {
            onDoneButtonTapped?()
        }
    }
    
    class Coordinator {}
}
