//
//  GoogleSSOManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/10/23.
//

import Foundation
import GoogleSignIn

class GoogleSSOManager: SSOProtocol {
    
    public func signIn(
        successAction: @escaping SSOSuccess,
        errorAction: @escaping SSOFailure
    ) {
        GIDSignIn.sharedInstance.signIn(
           withPresenting: getRootViewController()
        ) { signInResult, error in
            guard error == nil else {
                errorAction(error)
                return
            }
            
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            successAction(user.profile?.email)
        }
        
    }
    
    public func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    public func disconnect() {
        GIDSignIn.sharedInstance.disconnect { error in
            guard error == nil else { return }
            // Google Account disconnected from your app.
            // Perform clean-up actions, such as deleting data associated with the
            // disconnected account.
        }
    }
}

extension GoogleSSOManager {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }

        return root
    }
}
