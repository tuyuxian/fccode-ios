//
//  NationalityTag.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct NationalityTag: View {
    
    @State var nationality: Nationality

    var action: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 8) {
            Text(nationality.name)
                .fontTemplate(.pMedium)
                .foregroundColor(Color.text)
            
            Button {
                action()
            } label: {
                Image("CloseCircle")
                    .resizable()
                    .frame(
                        width: 24,
                        height: 24
                    )
            }

        }
        .padding(.horizontal, 10)
        .frame(height: 36)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.yellow20)
        )
    }
}

struct NationalityTag_Previews: PreviewProvider {
    static var previews: some View {
        NationalityTag(
            nationality: Nationality(
                name: "Taiwan",
                code: "TW"
            )
        )
    }
}
