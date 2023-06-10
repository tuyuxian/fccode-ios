//
//  NationalityPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/4/23.
//

import SwiftUI

struct NationalityPicker: View {
    
    @StateObject var vm: NationalityViewModel = NationalityViewModel()
    
    @Binding var nationalityList: [Nationality]

    @State var isSheetPresented = false
    
    @State var isPreference: Bool
    
    @State var countryName = ""
    
    var body: some View {
        ZStack {
            Color.white
                .frame(height: 56)
                .cornerRadius(50)
            
            Image("Search")
                .foregroundColor(Color.text)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
                .padding(.trailing, 16)
            
            if nationalityList.count != 0 {
                NationalitySearchBar(
                    vm: vm,
                    nationalityList: $nationalityList,
                    countryName: $countryName,
                    isDisplay: true,
                    isSheet: false
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
                    .padding(.trailing, 40)
                    .frame(height: 56)
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
            NationalityEditSheet(
                vm: vm,
                nationalityList: $nationalityList,
                isPreference: $isPreference
            )
        }
    }
}

struct NationalityPicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NationalityPicker(
                nationalityList: .constant([]),
                isPreference: false
            )
            NationalityPicker(
                nationalityList: .constant([
                    Nationality(
                        name: "Taiwan",
                        code: "Tw"
                    )
                ]),
                isPreference: false
            )
        }
        .padding(.horizontal, 24)
    }
}
