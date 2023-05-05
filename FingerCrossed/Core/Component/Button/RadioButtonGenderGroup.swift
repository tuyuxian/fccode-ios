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
            
            RadioButton(id: Gender.NONBINARY.rawValue, label: Gender.NONBINARY.rawValue, isSelected: selectedId == Gender.NONBINARY.rawValue ? true : false, callback: radioGroupCallback)
            
            hasDivider ? Divider().foregroundColor(Color.surface3) : nil
            
            RadioButton(id: Gender.PREFERNOTTOSAY.rawValue, label: Gender.PREFERNOTTOSAY.rawValue, isSelected: selectedId == Gender.PREFERNOTTOSAY.rawValue ? true : false, callback: radioGroupCallback)
            
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
