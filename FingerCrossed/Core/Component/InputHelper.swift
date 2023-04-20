//
//  InputHelper.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct InputHelper: View {
    var iconName: String = "CheckCircleBased"
    var label: String = "At least 8 characters"
    
    var body: some View {
        HStack (spacing: 6.0){
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
            
            Text(label)
                .font(.noteMedium)
                .foregroundColor(Color.text)
            
        }
    }
}

struct InputHelper_Previews: PreviewProvider {
    static var previews: some View {
        InputHelper()
    }
}
