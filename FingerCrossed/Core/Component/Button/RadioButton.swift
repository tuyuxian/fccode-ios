//
//  RadioButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 4/8/23.
//

import SwiftUI

struct RadioButton: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isSelected:Bool
    let isCheckBox: Bool
    let isWhiteBox: Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.text,
        textSize: CGFloat = 14,
        isSelected: Bool = false,
        isCheckBox: Bool = false,
        isWhiteBox: Bool = true,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isSelected = isSelected
        self.isCheckBox = isCheckBox
        self.isWhiteBox = isWhiteBox
        self.callback = callback
    }

    
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }){
            HStack {
                
                Text(label)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                
                Spacer()
                
                if isCheckBox {
                    isSelected ? Image("CheckBox").foregroundColor(Color.gold) : Image("UncheckBox").renderingMode(.template).foregroundColor(isWhiteBox ? Color.white : Color.surface3)
                }else {
                    isSelected ? Image("RadioSelected").foregroundColor(Color.gold) : Image("RadioDefault").renderingMode(.template).foregroundColor(isWhiteBox ? Color.white : Color.surface3)
                }
                
                
            }
            .contentShape(Rectangle())
        }
        
    }
}


struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(id: "", label: "label") { _ in
            //
        }
    }
}
