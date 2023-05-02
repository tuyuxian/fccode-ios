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
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
            
            if countrySelectionList.countrySlections.count != 0 {
                CountrySearchBar(countrySelectionList: countrySelectionList, countryName: $countryName, isDisplay: true)
                
//                ForEach(countrySelectionList.countrySlections) { countryselected in
//                    HStack (spacing: 4.0){
//                        Text(countryselected.name)
//                            .padding(.leading, 8)
//                            .padding(.vertical, 6)
//
//                        Button{
//                            countrySelectionList.countrySlections.removeAll(where: { $0 == countryselected })
//                        } label: {
//                            Image(systemName: "xmark.circle")
//                        }
//                        .padding(.trailing, 8)
//                    }
//                    .frame(height: 32)
//                    .background(
//                        RoundedRectangle(cornerRadius: 50)
//                            .fill(Color.orange)
//                    )
//                }
            }else {
                Text("Search")
                    .foregroundColor(Color.textHelper)
                    .fontTemplate(.pRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.surface2, lineWidth: 1)
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            print("Sheet dismissed")
            print(self.countrySelectionList.countrySlections.count)
        } content: {
            CountryView(countrySelectionList: countrySelectionList)
                .presentationDetents([.large])
        }
    }
}

struct NationalityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NationalityPickerView(countrySelectionList: CountrySelectionList(countrySlections: [CountryModel]()))
    }
}
