//
//  NavigationHeader.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct NavigationHeader: View {
    @State var parentTitle: String
    @State var childTitle: String
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Text(parentTitle)
                    .font(.h3Medium) // TODO(Sam): change to h4 medium
                    .foregroundColor(Color.surface2) // TODO(Sam): change to surface3
                    .frame(height: 20)
                    .padding(.bottom, -5)
                Text(childTitle)
                    .font(.h1Medium)
                    .foregroundColor(Color.text)
                    .frame(height: 40)
            }
        }
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeader(parentTitle: "Parent", childTitle: "Child")
    }
}
