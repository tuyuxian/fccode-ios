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
    @Binding var isSelected: Int
    
    var body: some View {
        Button {
            isSelected = tag
        } label: {
            Text(label)
                .fontTemplate(.captionRegular)
                .foregroundColor(Color.text)
                .padding(.bottom, -1) // offset text padding
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)) // leave 1 padding for border line
                .background(isSelected == tag ? Color.yellow100 : Color.yellow20)
                .cornerRadius(50)
        }
    }
}

struct TagButton_Previews: PreviewProvider {
    static var previews: some View {
        TagButton(label: "16:9", tag: .constant(0), isSelected: .constant(0))
    }
}
