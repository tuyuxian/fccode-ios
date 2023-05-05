//
//  SignUpBirthdayView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpBirthdayView: View {
    @ObservedObject var user: EntryViewModel
    @State var isOld = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                
                SignUpProcessBar(status: 2)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 24)
                
                
                
                HStack {
                    Text("Tell us about your...")
                        .fontTemplate(.h3Bold)
                        .foregroundColor(Color.text)
                    
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
                .padding(.top, 4)
                
                
                Spacer()
                    .frame(height: 60)
                
                DatePickers(monthIndex: $user.monthIndex, dayIndex: $user.dayIndex, yearIndex: $user.yearIndex)
                    .padding(.horizontal, 24)
                    .onChange(of: user.monthIndex) { newMonth in
                        getSelectedDate()
                    }
                    .onChange(of: user.yearIndex) { newYear in
                        getSelectedDate()
                    }
                    .onChange(of: user.dayIndex) { newDay in
                        getSelectedDate()
                    }
 
                InputHelper(isSatisfied: $isOld,label: "You must be over 18")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                
                
                Spacer()
                
                Button {
                    isOld ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: isOld ? Color.text : Color.white, buttonColor: isOld ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                
            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpGenderView(user: user)
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
    
    func toTwoDigit(index: Int) -> String{
        return index+1 < 10 ? "0\(index+1)" : "\(index+1)"
    }
    
    func getSelectedDate(){
        let currentYear = Calendar.current.component(.year, from: Date())
        
        user.dateOfBirth = "\(currentYear-(100-Int(toTwoDigit(index: user.yearIndex))!))-\(toTwoDigit(index: user.monthIndex))-\(toTwoDigit(index: user.dayIndex))T00:00:00Z"
        print("date: \(user.dateOfBirth)")
        
        let selectedString = "0\(toTwoDigit(index: user.dayIndex))/0\(toTwoDigit(index: user.monthIndex))/\(currentYear-(100-Int(toTwoDigit(index: user.yearIndex))!))"
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yy"
        
        let selectedDate = dateFormater.date(from: selectedString)!
        
        let yearGap = Calendar.current.dateComponents([.year], from: selectedDate, to: Date.now)
        
        isOld = yearGap.year! >= 18 ? true : false
    }
}

struct SignUpBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdayView(user: EntryViewModel())
    }
}
