//
//  CaptionInputBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct CaptionInputBar: View {
    
    // Remember to offset 1px border line width when using this component.
    @Binding var text: String
    
    @State var hint: String
    
    @State var defaultPresentLine: Int = 1
    
    @State var lineLimit: Int
    
    @State var textLengthLimit: Int

    var body: some View {
        VStack(
            alignment: .trailing,
            spacing: 6
        ) {
            TextField(
                "",
                text: $text,
                prompt: Text(hint)
                    .font(Font.system(size: 16, weight: .regular))
                    .foregroundColor(Color.textHelper),
                axis: .vertical
            )
            .onChange(of: text) { _ in
                text = String(text.prefix(textLengthLimit))
            }
            .textFieldStyle(.plain)
            .padding(
                EdgeInsets(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16
                )
            )
            .lineLimit(defaultPresentLine...lineLimit)
            .font(Font.system(size: 16, weight: .regular))
            .foregroundColor(Color.text)
            .multilineTextAlignment(.leading)
            .overlay(
                  RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.surface2, lineWidth: 1)
            )
            
            Text("\(text.count)/\(textLengthLimit)")
                .fontTemplate(.captionRegular)
                .foregroundColor(Color.textHelper)
            
        }
        .padding(.horizontal, 1) // offset border width
    }
}

struct CaptionInputBar_Previews: PreviewProvider {
    static var previews: some View {
        CaptionInputBar(
            text: .constant("10"),
            hint: "Hint",
            lineLimit: 10,
            textLengthLimit: 5
        )
        .padding(.horizontal, 24)
    }
}
