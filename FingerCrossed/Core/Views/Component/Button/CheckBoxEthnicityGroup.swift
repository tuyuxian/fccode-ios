//
//  CheckBoxEthnicityGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct CheckBoxEthnicityGroup: View {
    
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
    @State var hasDivider: Bool = false
    @Binding var ethnicityList: [Ethnicity]
    
    let callback: (String) -> ()
    
    private func radioGroupCallback(
        id: String
    ) {
        let hasItem: Bool = selectedIdList.contains(where: { selected in
            selected == id
        })
        
        let et = EthnicityType.allCases.first(where: {
            $0.rawValue == id
        })
        
        if hasItem {
            selectedIdList.removeAll(where: { item in
                item == id
            })
            ethnicityList.removeAll { item in
                item.type == String(describing: et)
            }
        } else {
            selectedIdList.append(id)
            let ethnicity = Ethnicity(id: UUID(), type: String(describing: et))
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
                    callback: radioGroupCallback
                )
            }
        }
    }
}

private var selectedValues: Binding<[Ethnicity]> {
    Binding.constant([Ethnicity(id: UUID(), type: "Value")])
}

struct CheckBoxEthnicityGroup_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxEthnicityGroup(ethnicityList: selectedValues) {_ in}
            .padding(.horizontal, 24)
        
    }
}
