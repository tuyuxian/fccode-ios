//
//  TagButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/15/23.
//

import SwiftUI

struct TagButton: View {
    @State var label: String
    @Binding var tag: Int
    @Binding var isSelected: Int?
    
    var body: some View {
        Button {
            isSelected = tag
        } label: {
            Text(label)
                .fontTemplate(.captionRegular)
                .foregroundColor(isSelected == tag ? Color.white : Color.orange100)
                .padding(.bottom, -1) // offset text padding
                .padding(EdgeInsets(top: 3, leading: 9, bottom: 3, trailing: 9)) // leave 1 padding for border line
                .background(isSelected == tag ? Color.orange100 : Color.white)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.orange100, lineWidth: 1)
                )
        }
    }
}

struct TagButton_Previews: PreviewProvider {
    static var previews: some View {
        TagButton(label: "16:9", tag: .constant(0), isSelected: .constant(0))
    }
}
