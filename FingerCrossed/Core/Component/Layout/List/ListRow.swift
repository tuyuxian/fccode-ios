//
//  ListRow.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct ListRow<Content: View>: View {
    
    @State var label: String
    @State var icon: String = "ArrowRightBased" // replace the icon when needed
    @State var hasIcon: Bool = true
    @ViewBuilder var preview: Content
    
    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .fontTemplate(.h3Medium)
                .foregroundColor(Color.text)
                .frame(height: 24)
                .padding(.top, 2)
                .padding(.bottom, -2)
            Spacer()
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(label: "Demo list row") {}
    }
}


