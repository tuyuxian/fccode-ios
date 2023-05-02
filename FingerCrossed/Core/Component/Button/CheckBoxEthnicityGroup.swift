//
//  CheckBoxEthnicityGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct CheckBoxEthnicityGroup: View {
    
    
    @State var selectedIdList = [""]
    @State var hasDivider: Bool = false
    @Binding var ethnicityList: [Ethnicity]
    let callback: (String) -> ()
    
    var body: some View {
        VStack (spacing: hasDivider ? 16 : 20) {
            Group {
                RadioButton(id: EthnicityType.ET1.rawValue, label: EthnicityType.ET1.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET1.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET2.rawValue, label: EthnicityType.ET2.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET2.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET3.rawValue, label: EthnicityType.ET3.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET3.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET4.rawValue, label: EthnicityType.ET4.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET4.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET5.rawValue, label: EthnicityType.ET5.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET5.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET6.rawValue, label: EthnicityType.ET6.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET6.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET7.rawValue, label: EthnicityType.ET7.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET7.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            Group {
                RadioButton(id: EthnicityType.ET8.rawValue, label: EthnicityType.ET8.rawValue, isSelected: selectedIdList.contains(where: { item in
                    item == EthnicityType.ET8.rawValue
                }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
                
                hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            }
            
            RadioButton(id: EthnicityType.ET9.rawValue, label: EthnicityType.ET9.rawValue, isSelected: selectedIdList.contains(where: { item in
                item == EthnicityType.ET9.rawValue
            }) ? true : false, isCheckBox: true, isWhiteBox: !hasDivider, callback: radioGroupCallback)
        }
    }
    
    func radioGroupCallback(id: String) {
        
        let hasItem: Bool = selectedIdList.contains { selected in
            selected == id
        }
        let et = EthnicityType.allCases.first(where: { $0.rawValue == id })
        
        
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
        
}

private var selectedValues: Binding<[Ethnicity]> {
    Binding.constant([Ethnicity(id: UUID(), type: "Value")])
}

struct CheckBoxEthnicityGroup_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxEthnicityGroup(ethnicityList: selectedValues) { _ in
            //
        }
    }
}
