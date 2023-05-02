//
//  EntryView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI
import AuthenticationServices

struct EntryView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack (spacing: 0.0){
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Find Your\nPerfect match")
                        .foregroundColor(.text)
                        .fontTemplate(.bigBoldTitle)
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 30)
                
                PrimaryInputBar(isDisable: false, hasButton: true)
                    .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 30)
                
                DividerWithLabel()
                
                Spacer()
                    .frame(height: 30)
                
                
                VStack (spacing: 20){
                    Button {
                        print("facebook")
                    } label: {
                        Label("Continue with Facebook", image: "Fb")
                    }
                    .buttonStyle(SSOButton())
                    .padding(.horizontal, 24)
                    
                    Button {
                        print("google")
                    } label: {
                        Label("Continue with Google", image: "Google")
                    }
                    .buttonStyle(SSOButton(labelColor: Color.text, buttonColor: Color.white))
//                    .padding(.horizontal, 24)
//                    GoogleSignInButton(action: {})
//                        .frame(height: 52, alignment: .center)
//                        .buttonStyle(PlainButtonStyle())
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email]
                    } onCompletion: { result in
                        switch result {
                            case .success(let authResults):
                                print("Authorisation successful")
                                switch authResults.credential {
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                            guard let appleIDToken = appleIDCredential.identityToken else {
                                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                            }
                                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                              print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                              return
                                            }
                                    print("---\(idTokenString)")
                                    print("---\(String(describing: appleIDCredential.email))")
                                default:
                                    break
                                }
                            case .failure(let error):
                                print("Authorisation failed: \(error.localizedDescription)")
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 52)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(50)
                }
                .padding(.horizontal, 24)

                Spacer()
                
                
                
                
            }
        }
        
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
