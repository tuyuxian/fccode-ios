//
//  EntryRepository.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import GraphQLAPI

extension GraphAPI {
    
    public class func checkEmail(
        email: String
    ) async throws -> (Bool, Bool?, Bool?, Bool?, Bool?, String?, String?, String?, String?, String?) {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: CheckEmailQuery(email: email),
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
                    let appleSocialAccount = data.checkEmail.user?.socialAccount?.first { sa in
                        sa.platform == .apple
                    }
                    let facebookSocialAccount = data.checkEmail.user?.socialAccount?.first { sa in
                        sa.platform == .facebook
                    }
                    let googleSocialAccount = data.checkEmail.user?.socialAccount?.first { sa in
                        sa.platform == .google
                    }
                    switch data.checkEmail.statusCode {
                    case 200:
                        continuation.resume(
                            returning: (
                                data.checkEmail.user != nil,
                                data.checkEmail.user?.password != "",
                                data.checkEmail.user?.appleConnect,
                                data.checkEmail.user?.facebookConnect,
                                data.checkEmail.user?.googleConnect,
                                data.checkEmail.user?.username,
                                data.checkEmail.user?.profilePictureURL,
                                appleSocialAccount?.email,
                                facebookSocialAccount?.email,
                                googleSocialAccount?.email
                            )
                        )
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
    ) async throws -> (Int, String, String) {
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
                        guard let tokenData = data.signIn.token else {
                            continuation.resume(throwing: GraphQLError.tokenIsNil)
                            return
                        }
                        guard let userId = data.signIn.userId else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        continuation.resume(returning: (200, userId, tokenData))
                    case 401:
                        continuation.resume(returning: (401, "", ""))
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
    ) async throws -> (String, String) {
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
                        guard let tokenData = data.socialSignIn.token else {
                            continuation.resume(throwing: GraphQLError.tokenIsNil)
                            return
                        }
                        guard let userId = data.socialSignIn.userId else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        continuation.resume(returning: (userId, tokenData))
                    case 401:
                        continuation.resume(throwing: GraphQLError.unauthorized)
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
    ) async throws -> (String, String) {
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
                       guard let tokenData = data.createUser.token else {
                           continuation.resume(throwing: GraphQLError.tokenIsNil)
                           return
                       }
//                       let user = User(
//                        userId: userData.id,
//                        email: userData.email,
//                        password: userData.password,
//                        username: userData.username,
//                        dateOfBirth: userData.dateOfBirth,
//                        gender: Gender.allCases.first { gender in
//                            gender == userData.gender.value
//                        }!,
//                        profilePictureUrl: userData.profilePictureURL,
//                        selfIntro: userData.selfIntro ?? "",
//                        longitude: userData.longitude,
//                        latitude: userData.latitude,
//                        country: userData.country ?? "",
//                        administrativeArea: userData.administrativeArea ?? "",
//                        voiceContentURL: userData.voiceContentURL,
//                        googleConnect: userData.googleConnect,
//                        facebookConnect: userData.facebookConnect,
//                        appleConnect: userData.appleConnect,
//                        premium: userData.premium,
//                        goal: [],
//                        citizen: Array(userData.citizen?.map {
//                            Nationality(
//                                name: $0.countryName,
//                                code: $0.code
//                            )
//                        } ?? []),
////                        lifePhoto: Array(userData.lifePhoto?.map {
////                            LifePhoto(
////                                contentUrl: $0.contentURL,
////                                caption: $0.caption ?? "",
////                                position: 0,
////                                scale: 1,
////                                offset: CGSize.zero
////                            )
////                        } ?? []),
//                        lifePhoto: [
//                            LifePhoto(
//                                contentUrl: userData.lifePhoto?[0].contentURL ?? "",
//                                caption: "",
//                                position: 0,
//                                scale: 1,
//                                offset: CGSize.zero
//                            ),
//                            LifePhoto(
//                                contentUrl: "",
//                                caption: "",
//                                position: 1,
//                                scale: 1,
//                                offset: CGSize.zero
//                            ),
//                            LifePhoto(
//                                contentUrl: "",
//                                caption: "",
//                                position: 2,
//                                scale: 1,
//                                offset: CGSize.zero
//                            ),
//                            LifePhoto(
//                                contentUrl: "",
//                                caption: "",
//                                position: 3,
//                                scale: 1,
//                                offset: CGSize.zero
//                            ),
//                            LifePhoto(
//                                contentUrl: "",
//                                caption: "",
//                                position: 4,
//                                scale: 1,
//                                offset: CGSize.zero
//                            )
//                        ],
//                        socialAccount: [],
//                        ethnicity: Array(userData.ethnicity?.map {
//                            Ethnicity(type: $0.ethnicityType.value!)
//                        } ?? [])
//                       )
                       guard let userData = data.createUser.userId else {
                           continuation.resume(throwing: GraphQLError.userIsNil)
                           return
                       }
                       continuation.resume(returning: (userData, tokenData))
                   case 401:
                       continuation.resume(throwing: GraphQLError.unauthorized)
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
