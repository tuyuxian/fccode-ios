//
//  SignUpEthnicityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/21/23.
//

import SwiftUI

struct SignUpEthnicityView: View {
    @ObservedObject var user = EntryViewModel()
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                SignUpProcessBar(status: 4)
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
                    Text("Ethnicity")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)
                
                CheckBoxEthnicityGroup(ethnicityList: $user.ethnicity) { selected in
                    print("\(selected)")
                    print("Ethnicity: \(user.ethnicity.count)")
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                
                
                Spacer()
                
                Button {
                    user.ethnicity.count > 0 ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: user.ethnicity.count > 0 ? Color.text : Color.white, buttonColor: user.ethnicity.count > 0 ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpNationalityView(user: user)
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

struct SignUpEthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEthnicityView()
    }
}
