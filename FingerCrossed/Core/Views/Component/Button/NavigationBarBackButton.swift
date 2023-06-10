//
//  NavigationBarBackButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct NavigationBarBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("ArrowLeft")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                presentationMode.wrappedValue.dismiss()
            }
        )
    }
}

struct NavigationBarBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarBackButton()
    }
}
