//
//  CountrySectionHeaderView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/10/23.
//

import SwiftUI

struct CountrySectionHeaderView: View {
    let text: String
    
    //MARK: body
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .border(.gray)
            .overlay(
                Text(text)
                    .font(Font.system(size: 21))
                    .foregroundColor(Color.gray)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 6)
                    .frame(maxWidth: nil, maxHeight: nil, alignment: .leading),
                alignment: .leading
            )
        
    }
}

struct CountrySectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CountrySectionHeaderView(text: "A")
    }
}

