//
//  BoxTab.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct BoxTab: View {

    @Binding var isSelected: Int

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button{
                isSelected = 1
            } label: {
                Text("Edit")
            }
            .frame(width: 171, height: 48)
            .background(isSelected == 1 ? Color.orange100 : Color.orange60)
            .cornerRadius(50)
            Button{
                isSelected = 2
            } label: {
                Text("Preview")
            }
            .frame(width: 171, height: 48)
            .background(isSelected == 2 ? Color.orange100 : Color.orange60)
            .cornerRadius(50)
        }
        .frame(width: 342, height:48)
        .fontTemplate(.h3Medium)
        .foregroundColor(Color.white)
        .background(Color.orange60)
        .cornerRadius(50)

    }
}

struct BoxTab_Previews: PreviewProvider {
    static var previews: some View {
        BoxTab(isSelected: .constant(0))
    }
}
