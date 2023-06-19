//
//  NationalityItem.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct NationalityItem: View {
    
    let nationality: Nationality
    
    var isSelected: Bool = false
    
    init(
        nationality: Nationality,
        isSelected: Bool
    ) {
        self.nationality = nationality
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            HStack(
                alignment: .center,
                spacing: 6
            ) {
                Text(nationality.name)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .frame(height: 24)
                isSelected
                ? FCIcon.checkCirle
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.gold)
                    .frame(
                        width: 24,
                        height: 24
                    )
                : nil
            }
        }
    }
}

struct NationalityItem_Previews: PreviewProvider {
    static var previews: some View {
        NationalityItem(
            nationality: Nationality(
                name: "Taiwan",
                code: "TW"
            ),
            isSelected: true
        )
        .padding(.horizontal, 24)
    }
}
