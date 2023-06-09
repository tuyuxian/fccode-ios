//
//  ProfileRepository.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/1/23.
//

import Foundation
import GraphQLAPI

extension GraphAPI {
    
    public class func getUserById(
        userId: String
    ) async throws -> User? {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: GetUserByIdQuery(userId: userId),
                cachePolicy: .fetchIgnoringCacheData
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
                    switch data.getUserById.statusCode {
                    case 200:
                        guard let userData = data.getUserById.user else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        let user = User(
                            id: userData.id,
                            email: userData.email,
                            password: userData.password,
                            username: userData.username,
                            dateOfBirth: userData.dateOfBirth,
                            gender: Gender.allCases.first { gender in
                                gender == userData.gender.value
                            }!,
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
                            citizen: Array(userData.citizen?.map {
                                Nationality(
                                    name: $0.countryName,
                                    code: $0.code
                                )
                            } ?? []),
                            //                        lifePhoto: Array(userData.lifePhoto?.map {
                            //                            LifePhoto(
                            //                                contentUrl: $0.contentURL,
                            //                                caption: $0.caption ?? "",
                            //                                position: 0,
                            //                                scale: 1,
                            //                                offset: CGSize.zero
                            //                            )
                            //                        } ?? []),
                            lifePhoto: [
                                LifePhoto(
                                    contentUrl: userData.lifePhoto?[0].contentURL ?? "",
                                    caption: "",
                                    position: 0,
                                    scale: 1,
                                    offset: CGSize.zero
                                ),
                                LifePhoto(
                                    contentUrl: "",
                                    caption: "",
                                    position: 1,
                                    scale: 1,
                                    offset: CGSize.zero
                                ),
                                LifePhoto(
                                    contentUrl: "",
                                    caption: "",
                                    position: 2,
                                    scale: 1,
                                    offset: CGSize.zero
                                ),
                                LifePhoto(
                                    contentUrl: "",
                                    caption: "",
                                    position: 3,
                                    scale: 1,
                                    offset: CGSize.zero
                                ),
                                LifePhoto(
                                    contentUrl: "",
                                    caption: "",
                                    position: 4,
                                    scale: 1,
                                    offset: CGSize.zero
                                )
                            ],
                            socialAccount: [],
                            ethnicity: Array(userData.ethnicity?.map {
                                Ethnicity(type: $0.ethnicityType.value!)
                            } ?? [])
                        )
                        continuation.resume(returning: user)
                    case 401:
                        continuation.resume(throwing: GraphQLError.unauthorized)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.getUserById.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func updateUser(
        userId: String,
        input: UpdateUserInput
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: UpdateUserMutation(
                    userId: userId,
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
                    switch data.updateUser.statusCode {
                    case 200:
                        continuation.resume(returning: 200)
                    case 401:
                        continuation.resume(throwing: GraphQLError.unauthorized)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.updateUser.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func updatePassword(
        userId: String,
        oldPassword: GraphQLNullable<String>,
        newPassword: String
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: UpdatePasswordMutation(
                    userId: userId,
                    oldPassword: oldPassword,
                    newPassword: newPassword
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
                    switch data.updatePassword.statusCode {
                    case 200:
                        continuation.resume(returning: 200)
                    case 401:
                        continuation.resume(returning: 401)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.updatePassword.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func deleteAccount(
        userId: String
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: DeleteUserByIdMutation(
                    userId: userId
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
                    switch data.deleteUserById.statusCode {
                    case 200:
                        continuation.resume(returning: 200)
                    case 401:
                        continuation.resume(throwing: GraphQLError.unauthorized)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.deleteUserById.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public class func connectSocialAccount(
        userId: String,
        input: CreateSocialAccountInput
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: ConnectSocialAccountMutation(
                    userId: userId,
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
                    switch data.connectSocialAccount.statusCode {
                    case 200:
                        continuation.resume(returning: 200)
                    case 401:
                        continuation.resume(throwing: GraphQLError.unauthorized)
                    case 403:
                        continuation.resume(returning: 403)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.connectSocialAccount.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
