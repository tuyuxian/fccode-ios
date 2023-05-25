//
//  MenuList.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct MenuList: View {
    
    @State var childViewList: [ChildView]
    
    var body: some View {
        List {
            ForEach(
                Array(childViewList.enumerated()),
                id: \.element.id
            ) { index, childView in
                    LazyVStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ZStack {
                                ListRow(
                                    label: childView.label,
                                    showIndicator: childView.hasSubview
                                ) {
                                    childView.preview
                                }
                                childView.hasSubview
                                ? NavigationLink(
                                    destination: childView.subview
                                    .navigationBarBackButtonHidden(true)
                                    .toolbarRole(.editor)
                                ) {
                                    EmptyView()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .opacity(0)
                                : nil
                            }
                            .listRowBackground(Color.white)
                        }
                        .padding(.top, index == 0 ? 14 : 0) // 30 - 16 (ListRow) for the first item
                        
                        index != childViewList.count - 1
                        ? Divider().overlay(Color.surface3)
                            .padding(.horizontal, 24)
                        : nil
                    }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
            )
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .padding(
            EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )
        .listStyle(PlainListStyle())
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(
            childViewList: [
                ChildView(
                    label: "Demo",
                    subview: AnyView(EmptyView()))
            ]
        )
    }
}

struct ChildView: Identifiable {
    var id = UUID()
    var label: String
    var icon: String = ""
    var subview: AnyView = AnyView(EmptyView())
    var preview: AnyView = AnyView(EmptyView())
    var hasSubview: Bool = true
}
