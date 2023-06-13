//
//  FCList.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import SwiftUI

struct FCList<T: Hashable>: View {
    
    var destinationViewList: [DestinationView<T>] = []
    
    var body: some View {
        List {
            ForEach(
                Array(destinationViewList.enumerated()),
                id: \.element.id
            ) { index, destinationView in
                    LazyVStack(spacing: 0) {
                        HStack(spacing: 0) {
                            FCRow(
                                label: destinationView.label,
                                icon: destinationView.icon,
                                showIndicator: true
                            ) {
                                destinationView.previewText != ""
                                ? PreviewText(text: destinationView.previewText)
                                : nil
                            }.background(
                                NavigationLink(value: destinationView.subview) {}.opacity(0)
                            )
                        }
                        .padding(.top, index == 0 ? 14 : 0) // 30 - 16 (ListRow) for the first item
                        
                        index != destinationViewList.count - 1
                        ? Divider()
                            .overlay(Color.surface3)
                            .padding(.horizontal, 24)
                        : nil
                    }
            }
            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .padding(0)
        .listStyle(.plain)
    }
}

struct FCList_Previews: PreviewProvider {
    static var previews: some View {
        FCList<ProfileDestination>(
            destinationViewList: [
                DestinationView(
                    label: "List 1",
                    subview: .helpSupport
                ),
                DestinationView(
                    label: "List 2",
                    subview: .helpSupport
                )
            ]
        )
    }
}

struct DestinationView<T: Hashable>: Identifiable {
    var id = UUID()
    var label: String
    var icon: FCIcon = .arrowRight
    var previewText: String = ""
    var subview: T?
    var hasSubview: Bool = true
}
