//
//  CandidateDetailItem.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/17/23.
//

import SwiftUI

struct CandidateDetailItem: View {
    @State var iconName: String = "AgeWhite"
    @State var label: String = "Label"
    @State var iconColor: Color = Color.text
    @State var labelColor: Color = Color.text
    var body: some View {

        HStack (spacing: 4.0) {
            Image(iconName)
                .renderingMode(.template)
                .foregroundColor(iconColor)
            Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(labelColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct CandidateDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        CandidateDetailItem()
    }
}
