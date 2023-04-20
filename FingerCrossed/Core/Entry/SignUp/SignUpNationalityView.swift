//
//  SignUpNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNationalityView: View {
    @StateObject var countryViewModel = CountryViewModel()
    @StateObject var countrySelectionList: CountrySelectionList
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Nationality")
                        .foregroundColor(.text)
                    .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                NationalityPickerView(countryViewModel: countryViewModel, countrySelectionList: countrySelectionList)
                    .padding(.horizontal, 24)
                
                InputHelper(label: "Up to 3 Nationalities")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 16)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    
                
                
                
                
                Spacer()
                    .frame(height: 246)
                
                Button {
                    print("Continue")
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SignUpNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNationalityView(countryViewModel: CountryViewModel(), countrySelectionList: CountrySelectionList(countrySlections: [CountryModel]()))
    }
}
