//
//  HeaderButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct HeaderButton: View {
    
    @State var name: String = ""
    var action: () -> Void = {}
    
    var body: some View {
        Button(name) {
            action()
        }
        .font(.pMedium)
        .foregroundColor(Color.orange100)
    }
}

struct HeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButton(name: "Demo")
    }
}

