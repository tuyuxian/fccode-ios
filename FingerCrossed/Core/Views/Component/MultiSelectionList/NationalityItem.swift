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
    
    init(nationality: Nationality, isSelected: Bool) {
        self.nationality = nationality
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 6.0) {
                Text(nationality.name)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                    .padding(.vertical, 2)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading
                    )
                isSelected
                ? Image("CheckCircleBased")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.gold)
                    .frame(
                        width: 24,
                        height: 24,
                        alignment: .center
                    )
                : nil
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
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
    }
}
