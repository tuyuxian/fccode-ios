//
//  FacebookSSOManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/10/23.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookSSOManager: SSOProtocol {
    
    private let permissions = ["public_profile", "email"]
    
    private lazy var fbLoginManager = LoginManager()
    
    func signIn(
        successAction: @escaping SSOSuccess,
        errorAction: @escaping SSOFailure
    ) {
        fbLoginManager.logIn(
            permissions: permissions,
            from: nil
        ) { signInResult, error in
            guard error == nil else {
                errorAction(error)
                return
            }
            guard !(signInResult?.isCancelled ?? true) else {
                errorAction(error)
                return
            }
            guard signInResult?.grantedPermissions != nil,
            let token = AccessToken.current?.tokenString else {
                errorAction(error)
                return
            }
            
            self.requestUserInfo(
                token: token,
                successAction: successAction,
                errorAction: errorAction
            )
        }
    }
    
    func signOut() {
        fbLoginManager.logOut()
    }
    
    func disconnect() {
        if let token = AccessToken.current?.tokenString {
            let request = GraphRequest(
                graphPath: "/me/permissions/",
                parameters: [:],
                tokenString: token,
                version: nil,
                httpMethod: .delete
            )
            request.start()
        }
        fbLoginManager.logOut()
    }
    
    private func requestUserInfo(
        token: String,
        successAction: @escaping SSOSuccess,
        errorAction: @escaping SSOFailure
    ) {
        let params = ["fields": "id, name, email"]
        let profileInfoRequest = GraphRequest(graphPath: "me", parameters: params)
        profileInfoRequest.start { _, result, graphError in
            guard let userInfo = result as? [String: Any] else {
                errorAction(graphError)
                return
            }
//            let id = userInfo["id"] as? String
//            let name = userInfo["name"] as? String
            let email = userInfo["email"] as? String
            successAction(email)
        }
    }
}
