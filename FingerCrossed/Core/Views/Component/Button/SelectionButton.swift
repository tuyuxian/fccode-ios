//
//  SelectionButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 5/8/23.
//

import SwiftUI

struct SelectionButton: View {
    
    enum SelectionType {
        case radio
        case checkbox
    }
    
    let id: String
    let type: SelectionType
    let label: String
    let isSelected: Bool
    let isWhiteBackground: Bool
    let callback: (String) -> ()
    
    init(
        id: String,
        type: SelectionType,
        label: String,
        isSelected: Bool = false,
        isWhiteBackground: Bool = true,
        callback: @escaping (String) -> ()
    ) {
        self.id = id
        self.type = type
        self.label = label
        self.isSelected = isSelected
        self.isWhiteBackground = isWhiteBackground
        self.callback = callback
    }
    
    var body: some View {
        HStack {
            Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(Color.text)
            
            Spacer()
            
            switch type {
            case .checkbox:
                // swiftlint:disable void_function_in_ternary
                isSelected
                ? FCIcon.checkboxSelected
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.gold)
                : FCIcon.checkbox
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(
                        isWhiteBackground
                        ? Color.white
                        : Color.surface3
                    )
                // swiftlint:enable void_function_in_ternary
            case .radio:
                // swiftlint:disable void_function_in_ternary
                isSelected
                ? FCIcon.radioSelected
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.gold)
                : FCIcon.radio
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .foregroundColor(
                        isWhiteBackground
                        ? Color.white
                        : Color.surface3
                    )
                // swiftlint:enable void_function_in_ternary
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            callback(id)
        }
    }
}

struct SelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectionButton(
                id: "1",
                type: .radio,
                label: "radio"
            ) {_ in}
            SelectionButton(
                id: "1",
                type: .radio,
                label: "radio",
                isSelected: true
            ) {_ in}
            SelectionButton(
                id: "1",
                type: .radio,
                label: "radio"
            ) {_ in}
            SelectionButton(
                id: "2",
                type: .checkbox,
                label: "checkbox",
                isSelected: true
            ) {_ in}
        }
        .padding(.horizontal, 24)
    }
}
