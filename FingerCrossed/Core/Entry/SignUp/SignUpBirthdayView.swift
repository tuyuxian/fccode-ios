//
//  SignUpBirthdateView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpBirthdateView: View {
    //@ObservedObject var user = EntryViewModel()
    @State var selectedArray = [
        ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"],
        ["2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010"]
    ]
//    @State var birthday : Date
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                    .frame(height: 19)
                
//                SignUpProcessBar(status: 2)
//                    .padding(.vertical, 30)
//                    .padding(.horizontal, 24)
//                
                
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Birthday")
                        .foregroundColor(.text)
                    .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 14)
                
                CustomPickers(dataArrays: $selectedArray)
                    .frame(maxWidth: .infinity, alignment: .center)
//                    .onChange(of: selectedArray, perform: { date in
//                        user.dateOfBirth = ArrayToDate(dateArray: date)
//                        print(user.dateOfBirth!)
//                    })
                
//                ZStack {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 50)
//                            .stroke(Color.surface2, lineWidth: 1)
//                            .background(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .fill(Color.white)
//                            )
//                        .frame(height: 56)
//
//                        HStack {
//                            Spacer()
//
//                            Image(textfieldIsFocused ? "ArrowUpBased" : "ArrowDownBased")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 24, height: 24)
//                        }
//                        .padding(.horizontal, 16)
//                    }
//                    // TODO(Lawrence): set the hint's font to be p regular
//                    DatePickerTextField(placeholder: "Select your birthday", date: $birthday)
//                        .focused($textfieldIsFocused)
//                        .padding(.horizontal, 16)
//                        .frame(height: 56)
//
//                }
//                .padding(.horizontal, 24)
//                .padding(.vertical, 18)
                
                Spacer()
                    .frame(height: 76)
                
                Spacer()
                
                NavigationLink (destination: SignUpGenderView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading:
                            VStack(alignment: .center) {
                                NavigationBarBackButton()
                            }
                            .frame(height: 40)
                            .padding(.top, 24)
                            .padding(.leading, 14)
                    )) {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
            }
            
            
        }

    }
    
    func ArrayToDate(dateArray: [[String]]) -> Date{
        let year = dateArray[2]
        let month = dateArray[0]
        let day = dateArray[1]
        
        print("year: \(year)")
        print("month: \(month)")
        print("day: \(day)")
        
        return Date.now
    }
}

struct SignUpBirthdateView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdateView()
    }
}

