//
//  BoxTab.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

enum BasicInfoTabState: Int {
    case edit
    case preview
}

struct BoxTab: View {

    @Binding var isSelected: BasicInfoTabState

    var body: some View {
        HStack(
            alignment: .center,
            spacing: 0
        ) {
            Button {
                isSelected = .edit
            } label: {
                Text("Edit")
            }
            .frame(width: 171, height: 48)
            .background(isSelected == .edit ? Color.yellow100 : Color.yellow20)
            .cornerRadius(50)
            
            Button {
                isSelected = .preview
            } label: {
                Text("Preview")
            }
            .frame(width: 171, height: 48)
            .background(isSelected == .preview ? Color.yellow100 : Color.yellow20)
            .cornerRadius(50)
        }
        .frame(width: 342, height: 48)
        .fontTemplate(.h3Medium)
        .foregroundColor(Color.text)
        .background(Color.yellow20)
        .cornerRadius(50)
    }
}

struct BoxTab_Previews: PreviewProvider {
    static var previews: some View {
        BoxTab(isSelected: .constant(.edit))
    }
}
