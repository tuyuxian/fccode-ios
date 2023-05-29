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
                ? Image("CheckBox")
                    .foregroundColor(Color.gold)
                : Image("UncheckBox")
                    .renderingMode(.template)
                    .foregroundColor(
                        isWhiteBackground
                        ? Color.white
                        : Color.surface3
                    )
                // swiftlint:enable void_function_in_ternary
            case .radio:
                // swiftlint:disable void_function_in_ternary
                isSelected
                ? Image("RadioSelected")
                    .foregroundColor(Color.gold)
                : Image("RadioDefault")
                    .renderingMode(.template)
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
        }
        .padding(.horizontal, 24)
    }
}
