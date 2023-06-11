//
//  ListRow.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct ListRow<Content: View>: View {
    
    @State var label: String
    
    /// Replace the icon in different use cases
    @State var icon: String = "ArrowRight"
    
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
                ? Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
                : nil
            }
            preview
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(label: "Demo list row") {}
    }
}
