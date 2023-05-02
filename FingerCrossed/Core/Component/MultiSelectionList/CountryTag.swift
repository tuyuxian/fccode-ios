//
//  CountryTag.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct CountryTag: View {
    var countryModel: CountryModel = CountryModel(name: "Taiwan", code: "TW")
    
    var body: some View {
        HStack (spacing: 8.0){
            Text(countryModel.name)
                .padding(.leading, 10)
                .padding(.vertical, 6)
            
            Button{
                print("remove")
            } label: {
                Image("CloseCircle")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.trailing, 10)
            .padding(.vertical, 8)
        }
        .frame(height: 32)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.yellow20)
        )
    }
}

struct CountryTag_Previews: PreviewProvider {
    static var previews: some View {
        CountryTag()
    }
}

