//
//  DividerWithLabel.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct DividerWithLabel: View {
    var label: String = "Or"
    
    var body: some View {
        HStack(spacing: 10.0) {
            VStack {
                Divider()
            }
            
            Text(label)
                .fontTemplate(.pMedium)
            
            VStack {
                Divider()
            }
        }
        .padding(.horizontal, 24)
    }
}

struct DividerWithLabel_Previews: PreviewProvider {
    static var previews: some View {
        DividerWithLabel()
    }
}
