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
        email: String
    ) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: CheckEmailQuery(email: email),
                cachePolicy: .returnCacheDataElseFetch
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.checkEmail.statusCode {
                    case 200:
                        continuation.resume(returning: data.checkEmail.exist)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.checkEmail.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func signIn(
        email: String,
        password: String
    ) async throws -> (User?, String?) {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: SignInQuery(
                    email: email,
                    password: password
                ),
                cachePolicy: .fetchIgnoringCacheCompletely
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.signIn.statusCode {
                    case 200:
                        guard let userData = data.signIn.user else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        
                        guard let tokenData = data.signIn.token else {
                            continuation.resume(throwing: GraphQLError.tokenIsNil)
                            return
                        }
                        let user = User(
                         userId: userData.id,
                         email: userData.email,
                         password: userData.password,
                         username: userData.username,
                         dateOfBirth: userData.dateOfBirth,
                         gender: Gender.allCases.first { gender in
                             gender.getString() == userData.gender.rawValue
                         } ?? .PREFERNOTTOSAY,
                         profilePictureUrl: userData.profilePictureURL,
                         selfIntro: userData.selfIntro ?? "",
                         longitude: userData.longitude,
                         latitude: userData.latitude,
                         country: userData.country ?? "",
                         administrativeArea: userData.administrativeArea ?? "",
                         voiceContentURL: userData.voiceContentURL,
                         googleConnect: userData.googleConnect,
                         facebookConnect: userData.facebookConnect,
                         appleConnect: userData.appleConnect,
                         premium: userData.premium,
                         goal: [],
                         citizen: [],
                         lifePhoto: [],
                         socialAccount: [],
                         ethnicity: []
                        )
                        continuation.resume(returning: (user, tokenData))
                    case 401:
                        continuation.resume(throwing: GraphQLError.customError(data.signIn.message))
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.signIn.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func socialSignIn(
        email: String,
        platform: GraphQLEnum<GraphQLAPI.SocialAccountPlatform>
    ) async throws -> (User?, String?) {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: SocialSignInQuery(
                    email: email,
                    platform: platform
                ),
                cachePolicy: .fetchIgnoringCacheCompletely
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.socialSignIn.statusCode {
                    case 200:
                        guard let userData = data.socialSignIn.user else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        
                        guard let tokenData = data.socialSignIn.token else {
                            continuation.resume(throwing: GraphQLError.tokenIsNil)
                            return
                        }
                        let user = User(
                         userId: userData.id,
                         email: userData.email,
                         password: userData.password,
                         username: userData.username,
                         dateOfBirth: userData.dateOfBirth,
                         gender: Gender.allCases.first { gender in
                             gender.getString() == userData.gender.rawValue
                         } ?? .PREFERNOTTOSAY,
                         profilePictureUrl: userData.profilePictureURL,
                         selfIntro: userData.selfIntro ?? "",
                         longitude: userData.longitude,
                         latitude: userData.latitude,
                         country: userData.country ?? "",
                         administrativeArea: userData.administrativeArea ?? "",
                         voiceContentURL: userData.voiceContentURL,
                         googleConnect: userData.googleConnect,
                         facebookConnect: userData.facebookConnect,
                         appleConnect: userData.appleConnect,
                         premium: userData.premium,
                         goal: [],
                         citizen: [],
                         lifePhoto: [],
                         socialAccount: [],
                         ethnicity: []
                        )
                        continuation.resume(returning: (user, tokenData))
                    case 401:
                        continuation.resume(throwing: GraphQLError.customError(data.socialSignIn.message))
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.socialSignIn.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func createUser(
        input: CreateUserInput
    ) async throws -> (User?, String?) {
       return try await withCheckedThrowingContinuation { continuation in
           Network.shared.apollo.perform(
               mutation: CreateUserMutation(
                   input: input
               )
           ) { result in
               switch result {
               case .success:
                   guard (try? result.get().errors) == nil else {
                       continuation.resume(throwing: GraphQLError.unknown)
                       return
                   }
                   guard let data = try? result.get().data else {
                       continuation.resume(throwing: GraphQLError.unknown)
                       return
                   }
                   switch data.createUser.statusCode {
                   case 200:
                       guard let userData = data.createUser.user else {
                           continuation.resume(throwing: GraphQLError.userIsNil)
                           return
                       }
                       
                       guard let tokenData = data.createUser.token else {
                           continuation.resume(throwing: GraphQLError.tokenIsNil)
                           return
                       }
                       
                       let user = User(
                        userId: userData.id,
                        email: userData.email,
                        password: userData.password,
                        username: userData.username,
                        dateOfBirth: userData.dateOfBirth,
                        gender: Gender.allCases.first { gender in
                            gender.getString() == userData.gender.rawValue
                        } ?? .PREFERNOTTOSAY,
                        profilePictureUrl: userData.profilePictureURL,
                        selfIntro: userData.selfIntro ?? "",
                        longitude: userData.longitude,
                        latitude: userData.latitude,
                        country: userData.country ?? "",
                        administrativeArea: userData.administrativeArea ?? "",
                        voiceContentURL: userData.voiceContentURL,
                        googleConnect: userData.googleConnect,
                        facebookConnect: userData.facebookConnect,
                        appleConnect: userData.appleConnect,
                        premium: userData.premium,
                        goal: [],
                        citizen: [],
                        lifePhoto: [],
                        socialAccount: [],
                        ethnicity: []
                       )
                       continuation.resume(returning: (user, tokenData))
                   case 401:
                       continuation.resume(throwing: GraphQLError.customError(data.createUser.message))
                   default:
                       continuation.resume(throwing: GraphQLError.customError(data.createUser.message))
                   }
               case .failure(let error):
                   continuation.resume(throwing: error)
               }
           }
       }
    }
    
    public class func requestOTP(
        email: String
    ) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: RequestOTPQuery(email: email),
                cachePolicy: .fetchIgnoringCacheCompletely
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.requestOTP.statusCode {
                    case 200:
                        continuation.resume(returning: data.requestOTP.valid)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.requestOTP.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func verifyOTP(
        email: String,
        userOTP: String
    ) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: VerifyOTPQuery(
                    email: email,
                    userOTP: userOTP
                ),
                cachePolicy: .fetchIgnoringCacheCompletely
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.verifyOTP.statusCode {
                    case 200:
                        continuation.resume(returning: data.verifyOTP.valid)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.verifyOTP.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func resetPassword(
        email: String,
        password: String
    ) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: ResetPasswordMutation(
                    email: email,
                    password: password
                )
            ) { result in
                switch result {
                case .success:
                    guard (try? result.get().errors) == nil else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    guard let data = try? result.get().data else {
                        continuation.resume(throwing: GraphQLError.unknown)
                        return
                    }
                    switch data.resetPassword.statusCode {
                    case 200:
                        continuation.resume(returning: data.resetPassword.valid)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.resetPassword.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
