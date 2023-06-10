//
//  PreviewText.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct PreviewText: View {
    @State var text: String
    var body: some View {
        Text(text)
            .fontTemplate(.pRegular)
            .foregroundColor(Color.textHelper)
            .padding(.top, 6)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}

struct PreviewText_Previews: PreviewProvider {
    static var previews: some View {
        PreviewText(
            text: "preview text"
        )
    }
}
