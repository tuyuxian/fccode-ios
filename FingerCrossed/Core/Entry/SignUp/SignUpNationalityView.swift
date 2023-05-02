//
//  SignUpNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNationalityView: View {
    @ObservedObject var user: EntryViewModel
    @ObservedObject var countrySelectionList =  CountrySelectionList(countrySlections: [CountryModel]())
    @State var isStatisfied: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                SignUpProcessBar(status: 5)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                    
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
                .padding(.top, 4)
                
                NationalityPickerView(countrySelectionList: countrySelectionList)
                    .onChange(of: countrySelectionList.countrySlections, perform: { newValue in
//                        print("\(newValue)")
                        user.nationality = countrySelectionList.countrySlections
                        self.isStatisfied = user.nationality.count > 0
                    })
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                InputHelper(isSatisfied: $isStatisfied, label: "Up to 3 Nationalities")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 16)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    
                Spacer()
                
                Button {
                    user.nationality.count > 0 ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: user.nationality.count > 0 ? Color.text : Color.white, buttonColor: user.nationality.count > 0 ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpAvatarView(user: user)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    VStack(alignment: .center) {
                        NavigationBarBackButton()
                    }
                    .frame(height: 40)
                    .padding(.top, 24)
                    .padding(.leading, 14))
            .onDisappear{
                user.isQualified = false
            }
            
            
        }

    }
}

struct SignUpNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNationalityView(user: EntryViewModel(), countrySelectionList: CountrySelectionList(countrySlections: [CountryModel]()))
    }
}
