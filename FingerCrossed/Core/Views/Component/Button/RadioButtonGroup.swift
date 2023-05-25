//
//  RadioButtonGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct RadioButtonGroup: View {
    
    let callback: (String) -> ()
    @State var items: [String] = [
        "Male",
        "Female",
        "Transgender",
        "Nonbinary",
        "Prefer not to say"
    ]
    @State var selectedId: String = ""
    @State var hasDivider: Bool = false
    
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
        RadioButtonGroup { _ in}
            .padding(.horizontal, 24)
    }
}
