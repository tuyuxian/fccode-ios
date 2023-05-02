//
//  CaptionInputBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct CaptionInputBar: View {
    
    // Remember to offset 1px border line width when using this component.
    @State var text: String = ""
    @State var hint: String
    @State var defaultPresentLine: Int = 1
    @State var lineLimit: Int

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(hint)
                .font(Font.system(size: 16, weight: .regular))
                .foregroundColor(Color.textHelper),
            axis: .vertical
        )
        .textFieldStyle(.plain)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .lineLimit(defaultPresentLine...lineLimit)
        .fontTemplate(.pRegular)
        .foregroundColor(Color.text)
        .multilineTextAlignment(.leading)
        .padding(0)
        //.disabled(text.count >= 200) // TODO(Sam): dynamically disable textfield when reaching 200 characters
        .overlay(
              RoundedRectangle(cornerRadius: 16)
                .stroke(Color.surface2, lineWidth: 1)
        )
    }
}

struct CaptionInputBar_Previews: PreviewProvider {
    static var previews: some View {
        CaptionInputBar(hint: "Hint", lineLimit: 10)
    }
}
