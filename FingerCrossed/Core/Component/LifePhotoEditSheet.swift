//
//  LifePhotoEditSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/14/23.
//

import SwiftUI

struct LifePhotoEditSheet: View {
    @State var showModal: Bool = false
    @State private var selectedTag: Int?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                Text("Nice Picture!")
                    .fontTemplate(.h2Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 34)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .padding(.bottom, 16)
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.surface2)
                    .frame(height: 346)
                HStack(spacing: 12) {
                    TagButton(label: "16:9", tag: .constant(0), isSelected: $selectedTag)
                    TagButton(label: "9:16", tag: .constant(1), isSelected: $selectedTag)
                    TagButton(label: "4:3", tag: .constant(2), isSelected: $selectedTag)
                    TagButton(label: "3:4", tag: .constant(3), isSelected: $selectedTag)
                }
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
                VStack(alignment: .trailing,spacing: 6) {
                    CaptionInputBar(hint: "Add caption", lineLimit: 4)
                    Text("0/200")
                        .fontTemplate(.captionRegular)
                        .foregroundColor(Color.textHelper)

                }
                .padding(.bottom, 20)
                .padding(.horizontal, 1) // offset border width
                
                Button {
                } label: {
                    Text("Save")
                }
                .buttonStyle(PrimaryButton())
                .padding(.bottom, 20)
                
                Button {
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(SecondaryButton())
                
            }
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        .presentationDetents([.fraction(0.9)])
    }
}

struct LifePhotoEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoEditSheet()
    }
}
