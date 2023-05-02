//
//  PrimaryButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    var labelColor: Color = Color.text
    var buttonColor: Color = Color.yellow100
    
    
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
