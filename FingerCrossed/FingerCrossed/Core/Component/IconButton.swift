//
//  IconButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI

struct IconButtonWithBackground: ButtonStyle {
    var buttonColor: Color = Color.orange100
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 54, height: 54)
            .background(
                Circle()
                    .fill(buttonColor)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
}

