//
//  NavigationBarBackButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct NavigationBarBackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            FCIcon.arrowLeft
                .resizable()
                .frame(width: 24, height: 24)
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                dismiss()
            }
        )
    }
}

struct NavigationBarBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarBackButton()
    }
}
