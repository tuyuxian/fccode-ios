//
//  CheckboxButtonRow.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct CheckboxButtonRow: View {
    @State var label: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Button {
                isSelected.toggle()
            } label: {
                Text(label)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                
                Spacer()
                
                Image(isSelected ? "CheckBoxSelected" : "CheckBox")
            }
        }
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
    }
}

struct CheckboxButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxButtonRow(label: "CheckBoxSelected")
    }
}
