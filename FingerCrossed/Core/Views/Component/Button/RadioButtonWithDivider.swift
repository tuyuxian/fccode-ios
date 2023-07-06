//
//  RadioButtonWithDivider.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/18/23.
//

import SwiftUI

struct RadioButtonWithDivider: View {
        
    @State var items: [String] = []
    
    @State var selectedId: String = ""
    
    let callback: (String) -> ()
    
    private func radioGroupCallback(
        id: String
    ) {
        selectedId = id
        callback(id)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(
                Array(items.enumerated()),
                id: \.element.self
            ) { index, item in
                SelectionButton(
                    id: item,
                    type: .radio,
                    label: item,
                    isSelected: selectedId == item,
                    isWhiteBackground: false,
                    callback: radioGroupCallback
                )
                
                index != items.count - 1
                ? Divider().overlay(Color.surface3)
                : nil
            }
        }
    }
}

struct RadioButtonWithDivider_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonWithDivider(
            items: [
                "Male",
                "Female",
                "Transgender",
                "Nonbinary",
                "Prefer not to say"
            ],
            callback: { _ in }
        )
        .padding(.horizontal, 24)
    }
}
