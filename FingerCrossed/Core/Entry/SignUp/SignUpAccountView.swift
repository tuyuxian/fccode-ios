//
//  SignUpAccountView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpAccountView: View {
    @ObservedObject var user: EntryViewModel

    @State var isQualifiedLength: Bool = false
    @State var isQualifiedUpper: Bool = false
    @State var isQualifiedNumber: Bool = false
    @State var isQualifiedMatch: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)

                HStack {
                    Text("Welcome to\nJoin us")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
                
                VStack (spacing: 20){
                    Text(user.email)
                        .fontTemplate(.pRegular)
                        .foregroundColor(Color.surface1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 56)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.surface2, lineWidth: 1)
                                .background(
                                        RoundedRectangle(cornerRadius: 50)
                                            .fill(Color.surface2)
                                )
                            )
                    
//                    PrimaryInputBar(value: $user.email, isDisable: true, hasButton: false)//TODO(Lawrence): disable status
                    
                    PrimaryInputBar(value: $user.password, hint: "Please enter your password", isDisable: false, hasButton: false, isPassword: true, isQualified: $user.isQualified)
                        .onChange(of: user.password) { password in
                            isQualifiedLength = password.count > 8 ? true : false
                            
                            isQualifiedUpper = checkLowercase(str: password) && checkUppercase(str: password) ? true : false
                            
                            isQualifiedNumber = checkNumbers(str: password) && checkSymbols(str: password) ? true : false
                            
                            isQualifiedMatch = password == user.passwordConfirmed ? true : false
                            
                        }
                    
                    PrimaryInputBar(value: $user.passwordConfirmed, hint: "Confirm password", isDisable: false, hasButton: false, isPassword: true, isQualified: $user.isQualified)
                        .onChange(of: user.passwordConfirmed, perform: { passwordC in
                            isQualifiedMatch = user.password == passwordC ? true : false
                        })
                        .onSubmit {
                            isQualifiedMatch ? user.password = user.passwordConfirmed : nil
                        }
                }
                .padding(.horizontal, 24)
                
                HStack {
                    VStack (alignment: .leading, spacing: 6.0){
<<<<<<< HEAD
                        InputHelper(textcolor: isQualifiedLength ? Color.text : Color.surface1, imageColor: isQualifiedLength ? Color.text : Color.surface1)
                        
                        InputHelper(label: "At least one upper & one lowercase", textcolor: isQualifiedUpper ? Color.text : Color.surface1, imageColor: isQualifiedUpper ? Color.text : Color.surface1)
                        
                        InputHelper(label: "At least one number & symbol", textcolor: isQualifiedNumber ? Color.text : Color.surface1, imageColor: isQualifiedNumber ? Color.text : Color.surface1)
                        
                        InputHelper(label: "Match with password", textcolor: isQualifiedMatch ? Color.text : Color.surface1, imageColor: isQualifiedMatch ? Color.text : Color.surface1)
=======
                        InputHelper(isSatisfied: .constant(true), label: "At least 8 characters")
                        InputHelper(isSatisfied: .constant(true), label: "At least one upper & one lowercase")
                        InputHelper(isSatisfied: .constant(true), label: "At least one number & one symbol")
                        InputHelper(isSatisfied: .constant(false), label: "Match with password")
>>>>>>> release
                    }
                    .padding(.horizontal, 38.67)
                    
                    Spacer()
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                Button {
                    print("\(user.isQualified)")
                    isQualifiedUpper && isQualifiedNumber && isQualifiedLength && isQualifiedMatch ? user.isQualified = true : nil
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton(labelColor: isQualifiedUpper && isQualifiedLength && isQualifiedNumber ? Color.text : Color.white, buttonColor: isQualifiedMatch && isQualifiedUpper && isQualifiedLength && isQualifiedNumber ? Color.yellow100 : Color.surface2))
                .padding(.horizontal, 24)
                .padding(.bottom, 50)

            }
            .navigationDestination(isPresented: $user.isQualified) {
                SignUpNameView(user: user)
            }
            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(
//                leading:
//                    VStack(alignment: .center) {
//                        NavigationBarBackButton()
//                    }
//                    .frame(height: 40)
//                    .padding(.top, 24)
//                    .padding(.leading, 14))
            .onDisappear{
                user.isQualified = false
            }

        }
    }
        
    
    func checkNumbers(str: String) -> Bool {
        let checkingStr = CharacterSet(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
        
        return str.rangeOfCharacter(from: checkingStr) != nil ? true : false
    }
    
    func checkSymbols(str: String) -> Bool {
        let checkingStr = CharacterSet([".", "*", "&", "^", "%", "$", "#", "@", "(", ")", "!", "?", "/", "+", ":", ";", "=", "{", "}", "<", ">", "~", "-", "`", "'", ",", "|", "_"])
//        let checkingStr = CharacterSet(["~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "-", "+", "=", "{", "}", "|", "\", ";", "<", ">", ".", "?", "/"])
        
        return str.rangeOfCharacter(from: checkingStr) != nil ? true : false
    }
    
    func checkUppercase(str: String) -> Bool {
        let UppercaseLetters = CharacterSet.uppercaseLetters
        
        return str.rangeOfCharacter(from: UppercaseLetters) != nil ? true : false
    }
    
    func checkLowercase(str: String) -> Bool {
        let LowercaseLetters = CharacterSet.lowercaseLetters
        
        return str.rangeOfCharacter(from: LowercaseLetters) != nil ? true : false
    }
}

struct SignUpAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAccountView(user: EntryViewModel())
    }
}
