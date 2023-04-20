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
            ForEach(Array(childViewList.enumerated()), id: \.element.id) { index, childView in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ZStack {
                                ListRow(label: childView.label)
                                NavigationLink(
                                    destination: childView.view
                                    .navigationBarBackButtonHidden(true)
                                    .toolbarRole(.editor)
                                ){
                                    EmptyView()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .opacity(0)
                            }
                            .listRowBackground(Color.white)
                        }
                        .padding(.top, index == 0 ? 10 : 0) // 30 - 20 (ListRow) for the first item
                        
                        index != childViewList.count - 1
                        ? Divider().foregroundColor(Color.surface3) 
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        : nil
                    }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listStyle(PlainListStyle())
    }
}

struct MenuList_Previews: PreviewProvider {
    static var previews: some View {
        MenuList(childViewList: [ChildView(label: "Demo", view: AnyView(EmptyView()))])
    }
}

struct ChildView: Identifiable {
    var id = UUID()
    var label: String
    var view: AnyView
}
