//
//  Network.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import Apollo

struct Network {
    static var shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let url =  URL(string: "http://localhost:8080/api/graphql")!
        return ApolloClient(url: url)
    }()
}

public enum GraphQLError: Error {
    case userIsNil
    case tokenIsNil
    case unknown
    case customError(String)
}
