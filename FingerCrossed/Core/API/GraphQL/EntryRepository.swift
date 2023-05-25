//
//  EntryRepository.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import GraphQLAPI

class EntryRepository {
    
    public class func checkEmail(
        email: String,
        completion: @escaping (Bool?, String?) -> ()
    ) {
        Network.shared.apollo.fetch(
            query: CheckEmailQuery(email: email),
            cachePolicy: .returnCacheDataElseFetch
        ) { result in
            switch result {
            case .success:
                guard let data = try? result.get().data else { return }

                switch data.checkEmail.statusCode {
                case 200:
                    completion(data.checkEmail.exist, nil)
                default:
                    completion(false, data.checkEmail.message)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    public class func signIn(
        email: String,
        password: String,
        completion: @escaping (Bool, String?, String?) -> ()
    ) {
        Network.shared.apollo.fetch(
            query: SignInQuery(
                email: email,
                password: password
            ),
            cachePolicy: .fetchIgnoringCacheCompletely
        ) { result in
            switch result {
            case .success:
                guard let data = try? result.get().data else { return }

                switch data.signIn.statusCode {
                case 200:
                    completion(true, data.signIn.token, nil)
                case 401:
                    completion(false, nil, nil)
                default:
                    completion(false, nil, data.signIn.message)
                }
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            }
        }
    }
    
    public class func socialSignIn(
        email: String,
        platform: GraphQLEnum<GraphQLAPI.SocialAccountPlatform>,
        completion: @escaping (Bool, String?, String?) -> ()
    ) {
        Network.shared.apollo.fetch(
            query: SocialSignInQuery(
                email: email,
                platform: platform
            ),
            cachePolicy: .fetchIgnoringCacheCompletely
        ) { result in
            switch result {
            case .success:
                guard let data = try? result.get().data else { return }
                
                switch data.socialSignIn.statusCode {
                case 200:
                    completion(true, data.socialSignIn.token, nil)
                case 401:
                    completion(false, nil, data.socialSignIn.message)
                default:
                    completion(false, nil, data.socialSignIn.message)
                }
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            }
        }
    }
    
    public class func createUser(
        email: String,
        username: String,
        dataOfBirth: Time,
        gender: GraphQLEnum<GraphQLAPI.UserGender>,
        longitude: Double,
        latitude: Double,
        completion: @escaping (Bool, String?, String?) -> ()
    ) {
        Network.shared.apollo.perform(
            mutation: CreateUserMutation(
                input: CreateUserInput(
                    email: email,
                    username: username,
                    dateOfBirth: dataOfBirth,
                    gender: gender,
                    longitude: longitude,
                    latitude: latitude
                )
            )
        ) { result in
            switch result {
            case .success:
                guard let data = try? result.get().data else { return }
                
                switch data.createUser.statusCode {
                case 200:
                    completion(true, data.createUser.token, nil)
                case 401:
                    completion(false, nil, data.createUser.message)
                default:
                    completion(false, nil, data.createUser.message)
                }
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            }

        }
    }
}