//
//  CountryItemView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

import SwiftUI

struct CountryItemView: View {
    let countryModel: CountryModel
    var isSelected: Bool = false
    
    init(countryModel: CountryModel, isSelected: Bool) {
        self.countryModel = countryModel
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            HStack (spacing: 6.0){
                Image(isSelected ? "CheckBox" : "UncheckBox")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                
                Text(countryModel.name)
                    .font(.pMedium)
                    .foregroundColor(Color.text)
                    .padding(.vertical, 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
            }
            //Divider().background(Color.gray)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
    }
}

struct CountryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CountryItemView(countryModel: CountryModel(name: "Taiwan", code: "TW"), isSelected: false)
    }
}

