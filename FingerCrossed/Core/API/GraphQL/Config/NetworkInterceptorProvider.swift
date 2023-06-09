//
//  NetworkInterceptorProvider.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/3/23.
//

import Foundation
import Apollo
import ApolloAPI

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(
        for operation: Operation
    ) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
    
}
