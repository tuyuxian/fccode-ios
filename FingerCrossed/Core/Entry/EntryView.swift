//
//  EntryView.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//

import SwiftUI
import RegexBuilder
import AuthenticationServices

struct EntryView: View {
    @StateObject var user = EntryViewModel()
    
//    let emailPattern = Regex {
//      let word = OneOrMore(.word)
//      Capture {
//        ZeroOrMore {
//          word
//          "."
//        }
//        word
//      }
//      "@"
//      Capture {
//        word
//        OneOrMore {
//          "."
//          word
//        }
//      }
//    } // => Regex<(Substring, Substring, Substring)>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                VStack (spacing: 0.0){
                    
                    EntryLogo()
                        .padding(.top, 5)
                        .padding(.bottom, 55)
                    
                    HStack {
                        Text("Find Your\nPerfect match")
                            .foregroundColor(.text)
                            .fontTemplate(.bigBoldTitle)
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    PrimaryInputBar(value: $user.email, view: user.isNewUser ? AnyView(SignUpAccountView(user: user)) : AnyView(SignInView(user: user)),
                                isDisable: false,
                                hasButton: true,
                                isEmail: true,
                                isQualified: $user.isQualified)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 30)
                        .onChange(of: user.email) { newValue in
                            print("@: \(newValue.contains("@"))")
                            user.isQualified = newValue.contains("@")
                        }
                        
//                        .onChange(of: email) { newEmail in
//                            if let match = try emailPattern.firstMatch(in: newEmail) {
//                              let (wholeMatch, name, domain) = match.output
//                              // wholeMatch: "my.name@mail.swift.org"
//                              //       name: "my.name"
//                              //     domain: "mail.swift.org"
//
//                            }
//                        }
                    
                    DividerWithLabel()
                        .padding(.bottom, 30)
                    
                    
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
                        .padding(.horizontal, 24)
                        
                        Button {
                            print("yeah")
                        } label: {
                            Label("Continue with Apple", image: "Apple")
                        }
                        .buttonStyle(SSOButton(labelColor: Color.white, buttonColor: Color.text))
                        .padding(.horizontal, 24)
                    }
                    
                    Spacer()
                    
                }
                .onDisappear{
                    user.isQualified = false
                }
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
