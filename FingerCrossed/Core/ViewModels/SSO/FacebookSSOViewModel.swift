//
//  FacebookSSOViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/10/23.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookSSOViewModel: ObservableObject {
    let loginManager = LoginManager()
    
    func showFacebookLoginView() {
        loginManager.logIn(
            permissions: [
                "public_profile",
                "email"
            ],
            from: nil
        ) { _, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            let request = GraphRequest(
                graphPath: "me",
                parameters: ["field": "id, email"]
            )
            
            request.start { _, res, _ in
                guard let profileData = res as? [String: Any] else {return}
                print(profileData)
            }
        }
    }
}
