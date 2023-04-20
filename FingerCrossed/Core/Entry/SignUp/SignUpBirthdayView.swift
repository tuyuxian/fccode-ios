//
//  SignUpBirthdayView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpBirthdayView: View {
    @FocusState private var textfieldIsFocused: Bool
    @State var birthday : Date?
    
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
                    Text("Birthday")
                        .foregroundColor(.text)
                    .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                ZStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.surface2, lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                            )
                        .frame(height: 56)
                        
                        HStack {
                            Spacer()
                            
                            Image(textfieldIsFocused ? "ArrowUpBased" : "ArrowDownBased")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.horizontal, 16)
                    }
                    // TODO(Lawrence): set the hint's font to be p regular
                    DatePickerTextField(placeholder: "Select your birthday", date: $birthday)
                        .focused($textfieldIsFocused)
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)
                
                Spacer()
                    .frame(height: 266)
                
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

struct SignUpBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdayView()
    }
}
