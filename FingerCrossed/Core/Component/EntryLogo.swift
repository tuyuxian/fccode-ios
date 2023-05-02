//
//  EntryLogo.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct EntryLogo: View {
    var body: some View {
        HStack (spacing: 6.0) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
            
            Image("FCVertical")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 76.18, height: 38)
        }
    }
}

struct EntryLogo_Previews: PreviewProvider {
    static var previews: some View {
        EntryLogo()
    }
}

