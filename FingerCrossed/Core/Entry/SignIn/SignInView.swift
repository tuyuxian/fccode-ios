//
//  SignInView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI

struct SignInView: View {
    var isPasswordCorrect: Bool = true
    @State var userAccount: String = "Testing123@gmail.com"
    @State var password: String = ""
    @State private var showEntryView: Bool = false
    @ObservedObject var user: EntryViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                
                EntryLogo()
                    .padding(.top, 5)
                    .padding(.bottom, 55)
                
                HStack {
                    Text("Glad to\nSee You Back")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 30)
                
                VStack (spacing: 20){
                    PrimaryInputBar(value: $userAccount, hint: userAccount, isDisable: false , hasButton: false, isQualified: $user.isQualified)
                    
                    PrimaryInputBar(value: $password, view: isPasswordCorrect ?  AnyView(PairingView(candidateList: [CandidateModel]())) : AnyView(EmptyView()), hint: "Password", isDisable: false, hasButton: true, isError: !isPasswordCorrect, isQualified: $user.isQualified)
                }
                .padding(.horizontal, 24)
                
                isPasswordCorrect ?
                nil:
                HStack (alignment: .top, spacing: 6.0){
                    Image("Error")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                    
                    Text("Wrong password.\nTry again or click “Forgot password” to reset it")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.warning )
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                DividerWithLabel()
                    .padding(.vertical, 30)
                
                VStack (spacing: 20){
                    ViewLink(view: ResetPasswordEmailCheckView())
                    
//                        NavigationLink(destination:
//                                        EntryView().navigationBarBackButtonHidden(true),
//                                       label: {
//                            Text("Log in with Social Media Account")
//                                .foregroundColor(Color.orange100)
//                                .fontTemplate(.pMedium)
//                                .frame(maxWidth: .infinity)
//                        })
                    
                    Button(action: {
                        showEntryView = true
                    }, label: {
                        Text("Log in with Social Media Account")
                            .foregroundColor(Color.gold)
                            .fontTemplate(.pMedium)
                            .frame(maxWidth: .infinity)
                    })
                    .padding(.horizontal, 24)
                    
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showEntryView) {
            EntryView()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(user: EntryViewModel())
    }
}
