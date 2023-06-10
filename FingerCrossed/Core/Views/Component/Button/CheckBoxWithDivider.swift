//
//  CheckBoxWithDivider.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/18/23.
//

import SwiftUI

struct CheckBoxWithDivider: View {
    
    @State var items: [String] = []
    
    @State var selectedIdList: [String] = []
        
    let callback: ([String]) -> ()
    
    private func checkBoxGroupCallback(
        id: String
    ) {
        let openToAll = id == "Everyone" || id == "Not sure yet"
        
        if openToAll {
            selectedIdList.removeAll()
            selectedIdList.append(id)
        } else {
            let hasClicked: Bool = selectedIdList.contains(where: { selected in
                selected == id
            })
            if hasClicked {
                selectedIdList.removeAll(where: { item in
                    item == id
                })
            } else {
                selectedIdList.append(id)
            }
            if selectedIdList.count == items.count - 1 {
                if items.contains(where: { id in
                    id == "Everyone"
                }) {
                    selectedIdList.removeAll()
                    selectedIdList.append("Everyone")
                }
//                if items.contains(where: { id in
//                    id == "Not sure yet"
//                }) {
//                    selectedIdList.removeAll()
//                    selectedIdList.append("Not sure yet")
//                }
            } else if selectedIdList.count == 0 {
                if items.contains(where: { id in
                    id == "Everyone"
                }) {
                    selectedIdList.append("Everyone")
                }
                if items.contains(where: { id in
                    id == "Not sure yet"
                }) {
                    selectedIdList.append("Not sure yet")
                }
            } else {
                selectedIdList.removeAll(where: { id in
                    id == "Everyone" || id == "Not sure yet"
                })
            }
        }
        callback(selectedIdList)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(
                Array(items.enumerated()),
                id: \.element.self
            ) { index, item in
                SelectionButton(
                    id: item,
                    type: .checkbox,
                    label: item,
                    isSelected: selectedIdList.contains(
                        where: { target in target == item}
                    ),
                    isWhiteBackground: false,
                    callback: checkBoxGroupCallback
                )
                
                index != items.count - 1
                ? Divider().overlay(Color.surface3)
                : nil
            }
        }
    }
}

struct CheckBoxWithDivider_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxWithDivider(
            items: [
                "Everyone",
                "American Indian",
                "Black/African American",
                "East Asian",
                "Hipanic/Latino",
                "Mid Eastern",
                "Pacific Islander",
                "South Asian",
                "Southeast Asian",
                "White/Caucasian"
            ],
            callback: { _ in }
        )
        .padding(.horizontal, 24)
    }
}
