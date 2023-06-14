//
//  FCRow.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct FCRow<Content: View>: View {
    
    @State var label: String
    
    /// Replace the icon in different use cases
    @State var icon: FCIcon = .arrowRight
    
    @State var showIndicator: Bool = true
        
    @ViewBuilder var preview: Content
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 0
        ) {
            HStack(spacing: 0) {
                Text(label)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                    .frame(height: 24)
                
                Spacer()
                
                showIndicator
                ? icon
                : nil
            }
            preview
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
    }
}

struct FCRow_Previews: PreviewProvider {
    static var previews: some View {
        FCRow(label: "Demo list row") {}
    }
}
