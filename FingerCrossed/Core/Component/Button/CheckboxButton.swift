//
//  CheckboxButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct CheckboxButton: View {
    @State var label: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack (spacing: 6) {
            isSelected ? Image("CheckBox") : Image("UncheckBox")
            
            Text(label)
                .font(.pMedium)
                .foregroundColor(Color.text)
        }
    }
}

struct CheckboxButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxButton(label: "Checkbox")
    }
}
