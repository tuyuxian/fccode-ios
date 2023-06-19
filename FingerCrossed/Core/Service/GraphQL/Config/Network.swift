//
//  Network.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import Apollo
import GraphQLAPI

struct Network {
    static var shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(
            client: client,
            store: store
        )
        
        let endpointURL: URL
        #if targetEnvironment(simulator)
            // Simulator
            endpointURL = URL(string: "http://localhost:8080/api/graphql")!
        #else
            // Real device
            endpointURL = URL(string: "http://204.236.147.60:8080/api/graphql")!
        #endif
        
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: endpointURL
        )
        
        return ApolloClient(
            networkTransport: transport,
            store: store
        )
    }()
}

public enum GraphQLError: Error {
    case userIsNil
    case tokenIsNil
    case unknown
    case unauthorized
    case customError(String)
}
