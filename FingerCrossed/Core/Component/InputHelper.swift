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
    var textcolor: Color = Color.surface1
    var imageColor: Color = Color.surface1
    
    var body: some View {
        HStack (spacing: 6.0){
            Image(iconName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(imageColor)
            
            Text(label)
                .fontTemplate(.noteMedium)
                .foregroundColor(textcolor)
            
        }
    }
}

struct InputHelper_Previews: PreviewProvider {
    static var previews: some View {
        InputHelper()
    }
}
