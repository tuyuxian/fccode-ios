//
//  PrimaryButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 5/6/23.
//

import SwiftUI

struct PrimaryButton: View {
    
    @State var label: String
    @State var action: () -> Void = {}
    @Binding var isTappable: Bool
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(isTappable ? Color.text : Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(isTappable ? Color.yellow100 : Color.surface2)
                .cornerRadius(50)
        }
        .disabled(!isTappable)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryButton(
                label: "Button",
                isTappable: .constant(true)
            )
            PrimaryButton(
                label: "Button",
                isTappable: .constant(false)
            )
        }
        .padding(.horizontal, 24)
    }
}
