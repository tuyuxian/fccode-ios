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
        .navigationBarItems(
            leading:
                HStack(spacing: 0) {
                    NavigationBarBackButton()
                        .padding(.top, 12)
                    NavigationHeader(
                        parentTitle: parentTitle,
                        childTitle: childTitle
                    )
                }
        )
        .navigationBarItems(
            trailing:
                showSaveButton
                ? VStack(alignment: .center) {
                    HeaderButton(
                        name: $iconButtonName,
                        action: action
                    )
                }
                .frame(height: 40)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 8))
                : nil
        )
        .padding(.top, 19)
        .background(Color.background)
        .edgesIgnoringSafeArea(.bottom)
        //.background(Color.background)
    }
}

struct ContainerWithHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerWithHeaderView(
            parentTitle: "Parent",
            childTitle: "Child",
            content: {}
        )
    }
}
