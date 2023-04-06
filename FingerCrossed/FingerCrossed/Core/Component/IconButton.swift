//
//  IconButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//  Modified by Yu-Hsien Tu on 4/6/23.
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

struct IconButton: View {
    
    @State var name: String
    var action: ()->()
    
    var body: some View {
        Button {
            action()
        } label: {
           Image(name)
               .resizable()
               .frame(width: 24, height: 24)
        }
    }
    
    static func emptyFunc() -> Void {}
    
    
    struct IconButton_Previews: PreviewProvider {
        static var previews: some View {
            IconButton(name: "Sent", action: emptyFunc)
        }
    }
}
