//
//  BoxTab.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct BoxTab: View {
    //@State var selection: [Int]
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button{} label: {
                Text("Edit")
            }
            .frame(width: 171, height: 48)
            .background(Color.orange100)
            .cornerRadius(50)
            Button{} label: {
                Text("Preview")
            }
            .frame(width: 171, height: 48)
        }
        .frame(width: 342, height:48)
        .fontTemplate(.pMedium)
        .foregroundColor(Color.white)
        .background(Color.orange60)
        .cornerRadius(50)
    }
}

struct BoxTab_Previews: PreviewProvider {
    static var previews: some View {
        BoxTab()
    }
}
