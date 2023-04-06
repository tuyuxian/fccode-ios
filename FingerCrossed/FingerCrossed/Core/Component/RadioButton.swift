//
//  RadioButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct RadioButton: View {
    var label: String = "Male"
    
    var body: some View {
        HStack (spacing: 6) {
            Image("RadioDefault")
            
            Text(label)
                .font(.pMedium)
                .foregroundColor(Color.text)
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton()
    }
}
