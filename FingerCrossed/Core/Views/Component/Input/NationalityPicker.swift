//
//  NationalityPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI

struct NationalityPicker: View {
    @State var nationalityViewModel: NationalityViewModel = NationalityViewModel()
    @ObservedObject var nationalitySelectionList: NationalitySelectionList
    @State var isSheetPresented = false
    @State var isPreference: Bool
    @State var countryName = ""
    
    var body: some View {

        ZStack {
            Color.white
                .frame(height: 56)
                .cornerRadius(50)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.text)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
                .padding(.trailing, 16)
            
            if nationalitySelectionList.nationalitySelections.count != 0 {
                NationalitySearchBar(
                    nationalitySelectionList: nationalitySelectionList,
                    countryName: $countryName,
                    isDisplay: true
                )
            } else {
                Text("Search")
                    .fontTemplate(.pRegular)
                    .foregroundColor(Color.textHelper)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding(.leading, 16)
                    .frame(height: 54)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(
                                Color.surface2,
                                lineWidth: 1
                            )
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            NationalityView(
                nationalitySelectionList: nationalitySelectionList,
                isPreference: $isPreference
            )
            .presentationDetents([.large])
        }
    }
}

struct NationalityPicker_Previews: PreviewProvider {
    static var previews: some View {
        NationalityPicker(
            nationalitySelectionList:
                NationalitySelectionList(
                    nationalitySelections: [Nationality]()
                ),
            isPreference: false
        )
    }
}
