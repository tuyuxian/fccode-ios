//
//  IconButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//  Modified by Sam on 4/6/23.
//

import SwiftUI

struct IconButton: View {
    
    @State var icon: FCIcon
    @State var color: Color
    var action: () -> () = {}
    
    var body: some View {
        Button {
            action()
        } label: {
            icon.resizable()
               .renderingMode(.template)
               .foregroundColor(color)
               .frame(width: 24, height: 24)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(
            icon: .picture,
            color: Color.text
        )
    }
}
