//
//  CheckBoxGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct CheckBoxGroup: View {
    
    @State var items: [String] = [
        "American Indian",
        "Black/African American",
        "East Asian",
        "Hipanic/Latino",
        "Mid Eastern",
        "Pacific Islander",
        "South Asian",
        "Southeast Asian",
        "White/Caucasian"
    ]
    @State var selectedIdList: [String] = []
    
    let callback: ([String]) -> ()
    
    private func checkBoxGroupCallback(
        id: String
    ) {
        let hasItem: Bool = selectedIdList.contains(where: { selected in
            selected == id
        })
        
        if hasItem {
            selectedIdList.removeAll(where: { item in
                item == id
            })
            ethnicityList.removeAll { item in
                item.type == et
            }
        } else {
            selectedIdList.append(id)
            let ethnicity = Ethnicity(
                id: UUID(),
                type: EthnicityType(rawValue: id) ?? .ET1
            )
            ethnicityList.append(ethnicity)
            callback(id)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(items, id: \.self) { item in
                SelectionButton(
                    id: item,
                    type: .checkbox,
                    label: item,
                    isSelected: selectedIdList.contains(
                        where: { target in target == item}
                    ),
                    callback: checkBoxGroupCallback
                )
            }
        }
    }
}

private var selectedValues: Binding<[Ethnicity]> {
    Binding.constant([Ethnicity(id: UUID(), type: .ET1)])
}

struct CheckBoxGroup_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxGroup { _ in}
            .padding(.horizontal, 24)
        
    }
}
