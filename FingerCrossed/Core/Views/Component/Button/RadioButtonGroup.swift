//
//  RadioButtonGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct RadioButtonGroup: View {
        
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
        VStack(spacing: 20) {
            ForEach(items, id: \.self) { item in
                SelectionButton(
                    id: item,
                    type: .radio,
                    label: item,
                    isSelected: selectedId == item,
                    callback: radioGroupCallback
                )
            }
        }
    }
}

struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroup(
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
