//
//  Box.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct Box<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(Color.white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .shadow(color: Color.surface5, radius: 40, x: 0, y: -16)
        
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        Box(content: {})
    }
}
