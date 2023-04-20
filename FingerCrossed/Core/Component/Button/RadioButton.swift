//
//  RadioButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 4/8/23.
//

import SwiftUI

struct RadioButton: View {
    @State var label: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack (spacing: 6) {
            isSelected ? Image("RadioSelected") : Image("RadioDefault")
            
            Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(Color.text)
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(label: "Label")
    }
}
