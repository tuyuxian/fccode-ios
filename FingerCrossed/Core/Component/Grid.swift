//
//  Grid.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/16/23.
//

import SwiftUI

struct Grid: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
        
    let rows: [GridItem] = [
        .init(.adaptive(minimum: 164, maximum: 164)),
    ]

    var body: some View {
        LazyHGrid(rows: rows, spacing: 10) {
            ForEach(items, id: \.self) { item in
                ItemView(text: item)
            }
        }
        //.frame(width: 340, height: 340)
        .padding()
        
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
    }
}

struct ItemView: View {
    let text: String

    var body: some View {
        ZStack {
            Color.blue
                .cornerRadius(10)
            Text(text)
                .foregroundColor(.white)
                .padding()
        }
    }
}
