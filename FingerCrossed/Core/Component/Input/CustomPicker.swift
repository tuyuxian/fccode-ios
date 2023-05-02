//
//  CustomPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import SwiftUI

import SwiftUI
import UIKit

struct CustomPicker: View {
    
    @State var selectedArray = [
        ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"],
        ["2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010"]
    ]
    

    var body: some View {
        CustomPickers(dataArrays: $selectedArray)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct CustomPickers: UIViewRepresentable {
    @Binding var dataArrays : [[String]]

    //makeCoordinator()
    func makeCoordinator() -> CustomPickers.Coordinator {
        return CustomPickers.Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<CustomPickers>) -> UIPickerView {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<CustomPickers>) {
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        var parent: CustomPickers
        init(_ pickerView: CustomPickers) {
            self.parent = pickerView
        }
        
        // for
//        private var years: [Int] = []
//        private var months: [Int] = []
//        private var days: [Int] = []
//        private var data: [[Int]]
//
//        public var date: Date = Date()
//        public var minimumDate: Date?
        
//        private func setupDateData(date: Date) {
//            self.date = date
//            let calendar = NSCalendar.current
//            let compt = calendar.dateComponents([.year, .month, .day], from: date)
//
//            guard let currentYear = compt.year, let currentMonth = compt.month, let currentDay = compt.day else {
//                return
//            }
//
//            var daysInCurrentMonth = 0
//            if let range = calendar.range(of: .day, in: .month, for: date) {
//                daysInCurrentMonth = range.count
//            }
//
//            for year in 1 ... currentYear {
//                years.append(year)
//            }
//
//            for month in 1 ... 12 {
//                months.append(month)
//            }
//
//            for day in 1 ... daysInCurrentMonth {
//                days.append(day)
//            }
//
//            data = [months, days, years]
//
//
////            DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
////                self?.pickView.selectRow(currentMonth - 1, inComponent: self?.monthComponent ?? 0, animated: true)
////                self?.pickView.selectRow(currentYear - 1, inComponent: self?.yearComponent ?? 2, animated: true)
////                self?.pickView.selectRow(currentDay - 1, inComponent: self?.dayComponent ?? 1, animated: true)
////            }
//        }
        
        

        //Number Of Components:
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            setupDateData(date: date)
            return parent.dataArrays.count
        }

        //Number Of Rows In Component:
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            setupDateData(date: date)
            return parent.dataArrays[component].count
        }

        //Width for component:
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return (UIScreen.main.bounds.width - 18 * 2) / 3
        }

        //Row height:
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50
        }

        //View for Row
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/3, height: 45))
//            setupDateData(date: date)
            

            let pickerLabel = UILabel(frame: view.bounds)

            pickerLabel.text = parent.dataArrays[component][row]
            
            pickerLabel.font = UIFont(name: "AzoSans-Medium", size: 16)
            pickerLabel.textColor = UIColor(Color.text)
            pickerLabel.textAlignment = .center

            view.addSubview(pickerLabel)

            view.clipsToBounds = false
            //view.layer.cornerRadius = 50
            
//            view.layer.cornerRadius = view.bounds.height * 0.1
            view.layer.backgroundColor = UIColor(.clear).cgColor
            
//            view.layer.borderWidth = 0.5
//            view.layer.borderColor = UIColor(Color.orange100).cgColor

            return view
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker()
    }
}
