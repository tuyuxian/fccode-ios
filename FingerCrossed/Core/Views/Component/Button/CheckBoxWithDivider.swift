//
//  CheckBoxWithDivider.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/18/23.
//

import SwiftUI

struct CheckBoxWithDivider: View {
    @State var items: [String] = [
        "Open to all",
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
        let isAllSelected = selectedIdList.contains { id in
            id == "Open to all"
        }
        
        if id != "Open to all" {
            let hasItem: Bool = selectedIdList.contains(where: { selected in
                selected == id
            })
            
            if hasItem {
                selectedIdList.removeAll(where: { item in
                    item == id
                })
                callback(selectedIdList)
            } else {
                selectedIdList.append(id)
                callback(selectedIdList)
            }
            
            if selectedIdList.count == items.count - 1 {
                if isAllSelected {
                    selectedIdList.removeAll(where: { id in
                        id == "Open to all"
                    })
                    callback(selectedIdList)
                } else {
                    selectedIdList.append("Open to all")
                    callback(selectedIdList)
                }
            } else {
                selectedIdList.removeAll(where: { id in
                    id == "Open to all"
                })
                callback(selectedIdList)
            }
        }
        else {
            if isAllSelected {
                selectedIdList.removeAll()
                callback(selectedIdList)
            } else {
                selectedIdList.removeAll()
                for item in items {
                    selectedIdList.append(item)
                }
                callback(selectedIdList)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(items.enumerated()), id: \.element.self) { index, item in
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
                ? Divider().foregroundColor(Color.surface3)
                : nil
            }
        }
    }
}

struct CheckBoxWithDivider_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxWithDivider { _ in}
            .padding(.horizontal, 24)
    }
}
