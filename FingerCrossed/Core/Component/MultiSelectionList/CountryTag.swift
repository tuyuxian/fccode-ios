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
        HStack (spacing: 4.0){
            Text(countryModel.name)
                .padding(.leading, 8)
                .padding(.vertical, 6)
            
            Button{
                print("remove")
            } label: {
                Image(systemName: "xmark.circle")
            }
            .padding(.trailing, 8)
        }
        .frame(height: 32)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.orange60)
        )
    }
}

struct CountryTag_Previews: PreviewProvider {
    static var previews: some View {
        CountryTag()
    }
}

