//
//  InputHelper.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct InputHelper: View {
    var icon: String = "CheckCircleBased"
    @Binding var isSatisfied: Bool
    @State var label: String = "At least 8 characters"
    
    var body: some View {
        HStack(spacing: 6.0) {
            
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(isSatisfied ? Color.text : Color.surface1)
            
            Text(label)
                .fontTemplate(.noteMedium)
                .foregroundColor(isSatisfied ? Color.text : Color.surface1)
        }
    }
}

struct InputHelper_Previews: PreviewProvider {
    static var previews: some View {
        InputHelper(isSatisfied: .constant(false),label: "Helper")
    }
}
