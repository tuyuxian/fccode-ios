//
//  AppleSSOViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/9/23.
//

import Foundation
import AuthenticationServices

class AppleSSOViewModel:
    NSObject,
    ASAuthorizationControllerDelegate {
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if appleIdCredential.email != nil, appleIdCredential.fullName != nil {
              // Apple has autherized the use with Apple ID and password
              registerNewUser(credential: appleIdCredential)
            } else {
              // User has been already exist with Apple Identity Provider
              signInExistingUser(credential: appleIdCredential)
            }
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            signinWithUserNamePassword(credential: passwordCredential)
        default:
            print("here")
        }
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
        // Give Call Back to UI
    }
    
    public func showAppleLoginView() {
        /// 1. Instantiate the AuthorizationAppleIDProvider
        let provider = ASAuthorizationAppleIDProvider()
        /// 2. Create a request with the help of provider - ASAuthorizationAppleIDRequest
        let request = provider.createRequest()
        /// 3. Scope to contact information to be requested from the user during authentication.
        request.requestedScopes = [.fullName, .email]
        /// 4. A controller that manages authorization requests created by a provider.
        let controller = ASAuthorizationController(authorizationRequests: [request])
        /// 5. Set delegate to perform action
        controller.delegate = self
        /// 6. Initiate the authorization flows.
        controller.performRequests()
    }
}

extension AppleSSOViewModel {
    private func registerNewUser(
        credential: ASAuthorizationAppleIDCredential
    ) {
        // API Call - Pass the email, user full name, user identity provided by Apple and other details.
        // Give Call Back to UI
        print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
        print(credential.email ?? "Email not available.")
    }
    private func signInExistingUser(
        credential: ASAuthorizationAppleIDCredential
    ) {
        // API Call - Pass the user identity, authorizationCode and identity token
        // Give Call Back to UI
        print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
        print(credential.email ?? "Email not available.")
    }
  
    private func signinWithUserNamePassword(
        credential: ASPasswordCredential
    ) {
        // API Call - Sign in with Username and password
        // Give Call Back to UI
        print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
        print(credential)
    }
}
