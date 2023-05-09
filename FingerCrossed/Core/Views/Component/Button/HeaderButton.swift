//
//  HeaderButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct HeaderButton: View {
    
    @Binding var name: String
    
    var action: () -> Void = {}
    
    var body: some View {
        Button(name) {
            action()
        }
        .fontTemplate(.pMedium)
        .foregroundColor(Color.gold)
    }
}

struct HeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButton(name: .constant("Demo"))
    }
}
