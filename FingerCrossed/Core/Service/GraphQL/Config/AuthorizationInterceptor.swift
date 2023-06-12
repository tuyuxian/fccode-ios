//
//  AuthorizationInterceptor.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/3/23.
//

import Foundation
import Apollo
import ApolloAPI

class AuthorizationInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        if let token = UserDefaults.standard.string(forKey: "UserToken") {
            request.addHeader(name: "Authorization", value: "Bearer \(token)")
        }
        
        chain.proceedAsync(
            request: request,
            response: response,
            completion: completion
        )
    }
    
}
