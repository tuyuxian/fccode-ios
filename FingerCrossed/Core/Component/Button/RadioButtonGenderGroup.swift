//
//  RadioButtonGenderGroup.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import SwiftUI

struct RadioButtonGenderGroup: View {
    let callback: (String) -> ()
        
    @State var selectedId: String = ""
    @State var hasDivider: Bool = false
    
    var body: some View {
        VStack (spacing: 20){
            
            RadioButton(id: Gender.MALE.rawValue, label: Gender.MALE.rawValue, isSelected: selectedId == Gender.MALE.rawValue ? true : false, callback: radioGroupCallback)
            
            hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            
            RadioButton(id: Gender.FEMALE.rawValue, label: Gender.FEMALE.rawValue, isSelected: selectedId == Gender.FEMALE.rawValue ? true : false, callback: radioGroupCallback)
            
            hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            
            RadioButton(id: Gender.TRANSGENDER.rawValue, label: Gender.TRANSGENDER.rawValue, isSelected: selectedId == Gender.TRANSGENDER.rawValue ? true : false, callback: radioGroupCallback)
            
            hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            
            RadioButton(id: Gender.NON_BINARY.rawValue, label: Gender.NON_BINARY.rawValue, isSelected: selectedId == Gender.NON_BINARY.rawValue ? true : false, callback: radioGroupCallback)
            
            hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            
            RadioButton(id: Gender.PREFER_NOT_TO_SAY.rawValue, label: Gender.PREFER_NOT_TO_SAY.rawValue, isSelected: selectedId == Gender.PREFER_NOT_TO_SAY.rawValue ? true : false, callback: radioGroupCallback)
            
        }
    }
    
    func radioGroupCallback(id: String) {
            selectedId = id
            callback(id)
        }
}

struct RadioButtonGenderGroup_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGenderGroup { _ in
            //
        }
    }
}
