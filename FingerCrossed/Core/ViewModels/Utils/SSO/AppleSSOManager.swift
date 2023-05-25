//
//  AppleSSOManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/9/23.
//

import Foundation
import AuthenticationServices
import JWTDecode

class AppleSSOManager:
    NSObject,
    ASAuthorizationControllerDelegate {
    
    private var continuation: CheckedContinuation<String?, Error>?
    
    public func signIn() async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            let appleIDProviderRequest = ASAuthorizationAppleIDProvider().createRequest()
            appleIDProviderRequest.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(
                authorizationRequests: [appleIDProviderRequest]
            )
            authorizationController.delegate = self
            authorizationController.performRequests()
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let identityTokenData = appleIdCredential.identityToken,
               let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                do {
                    let jwt = try decode(jwt: identityTokenString)
                    let decodedBody = jwt.body as [String: Any]
                    continuation?.resume(returning: decodedBody["email"] as? String)
                } catch {
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
        
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        continuation?.resume(throwing: error)
    }
}
