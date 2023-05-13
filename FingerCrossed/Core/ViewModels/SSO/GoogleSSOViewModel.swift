//
//  GoogleSSOViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/10/23.
//

import Foundation
import GoogleSignIn

class GoogleSSOViewModel: ObservableObject {
    public func showGoogleLoginView() {
        GIDSignIn.sharedInstance.signIn(
           withPresenting: getRootViewController()) { signInResult, error in
               guard error == nil else { return }
               guard let signInResult = signInResult else { return }

               let user = signInResult.user

               let emailAddress = user.profile?.email
               print(emailAddress ?? "Email is nil")

             // If sign in succeeded, display the app's main content View.
           }
    }
}

extension GoogleSSOViewModel {
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
