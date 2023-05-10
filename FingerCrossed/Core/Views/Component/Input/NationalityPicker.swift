//
//  NationalityPickerView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI

struct NationalityPickerView: View {
    @State var countryViewModel: CountryViewModel = CountryViewModel()
    @ObservedObject var countrySelectionList: CountrySelectionList
    @State var isSheetPresented = false
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
            
            if countrySelectionList.countrySelections.count != 0 {
                CountrySearchBar(
                    countrySelectionList: countrySelectionList,
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
            CountryView(countrySelectionList: countrySelectionList)
                .presentationDetents([.large])
        }
    }
}

struct NationalityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NationalityPickerView(
            countrySelectionList: CountrySelectionList(countrySelections: [CountryModel]())
        )
    }
}