//
//  EmailCheckTest.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/13/23.
//

import Foundation
import Apollo
import GraphQLAPI

let apolloClient = ApolloClient(url: URL(string: "http://localhost:8080/query")!)

final class TestViewModel: ObservableObject {

    func fetch(email: String) {
        apolloClient.fetch(
            query: EmailCheckQuery(email: email)
        ) { result in
            switch result {
            case .success(let graphQLResult):
                print("Result: \(graphQLResult.data?.emailCheck)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}
