//
//  EntryLogo.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct EntryLogo: View {
    var body: some View {
        VStack (spacing: 4.0) {
            Image("EntryLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 56, height: 41)
            Text("Finger Crossed")
                .font(.noteMedium)
                .foregroundColor(Color.text)
        }
    }
}

struct EntryLogo_Previews: PreviewProvider {
    static var previews: some View {
        EntryLogo()
    }
}

