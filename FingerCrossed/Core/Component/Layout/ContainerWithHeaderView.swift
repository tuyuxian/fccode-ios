//
//  ContainerWithHeaderView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct ContainerWithHeaderView<Content: View>: View {
    
    @State var parentTitle: String
    @State var childTitle: String
    @State var showSaveButton: Bool = true
    @State var iconButtonName: String = "Save"
    @State var action: ()->() = {}
    @ViewBuilder var content: Content
    
    
    var body: some View {
        ZStack {
            content
        }
        .navigationBarItems(leading:
            HStack(spacing: 0) {
                NavigationBarBackButton()
                .padding(.top, 12)
                .padding(.leading, -1)
                NavigationHeader(parentTitle: parentTitle, childTitle: childTitle)
            }
            // top navbar height is 44px in default
            // navbar title with subtile is 55px
            // to achieve 60px from top => 60 + 55 - 59(safe area) - 44 = 12
            .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
        )
        .navigationBarItems(trailing:
            showSaveButton
            ? VStack(alignment: .center) {
                HeaderButton(name: iconButtonName, action: action)
                }
                .frame(height: 40)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 8))
            : nil
        )
        .padding(.top, 30)
        .background(Color.background)
    }
}

struct ContainerWithHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerWithHeaderView(parentTitle: "Parent", childTitle: "Child", content: {})
    }
}
