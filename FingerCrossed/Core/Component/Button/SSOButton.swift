//
//  SSOButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct SSOButton: ButtonStyle {
    var labelColor: Color = Color.white
    var buttonColor: Color = Color.facebook
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontTemplate(.pMedium)
            .foregroundColor(labelColor)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: 66)
                    .fill(buttonColor)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
}
