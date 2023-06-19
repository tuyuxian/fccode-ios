//
//  MediaService.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import Foundation
import GraphQLAPI

struct MediaService {
    
    static public func getPresignedPutUrl(
        _ sourceType: GraphQLEnum<MediaSourceType>
    ) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: GetS3PresignedPutUrlQuery(sourceType: sourceType),
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
                    switch data.getS3PresignedPutUrl.statusCode {
                    case 200:
                        continuation.resume(returning: data.getS3PresignedPutUrl.url)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.getS3PresignedPutUrl.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    static public func getPresignedDeleteUrl(
        fileName: String
    ) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.fetch(
                query: GetS3PresignedDeleteUrlQuery(
                    fileName: fileName
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
                    switch data.getS3PresignedDeleteUrl.statusCode {
                    case 200:
                        continuation.resume(returning: data.getS3PresignedDeleteUrl.url)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.getS3PresignedDeleteUrl.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    static public func createLifePhoto(
        userId: String,
        input: CreateLifePhotoInput
    ) async throws -> (Int, [LifePhoto]) {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: CreateLifePhotoMutation(
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
                    switch data.createLifePhoto.statusCode {
                    case 200:
                        guard let userData = data.createLifePhoto.user else {
                            continuation.resume(throwing: GraphQLError.userIsNil)
                            return
                        }
                        let lifePhotos = Array(userData.lifePhoto?.map {
                            LifePhoto(
                                id: $0.id,
                                contentUrl: $0.contentURL,
                                caption: $0.caption ?? "",
                                position: $0.position,
                                scale: $0.scale,
                                offset: CGSize(width: $0.offsetX, height: $0.offsetY)
                            )
                        } ?? [])
                        continuation.resume(returning: (200, lifePhotos))
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.createLifePhoto.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    static public func deleteLifePhoto(
        userId: String,
        lifePhotoId: String
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.apollo.perform(
                mutation: DeleteLifePhotoMutation(
                    userId: userId,
                    lifePhotoId: lifePhotoId
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
                    switch data.deleteLifePhoto.statusCode {
                    case 200:
                        continuation.resume(returning: 200)
                    default:
                        continuation.resume(throwing: GraphQLError.customError(
                            data.deleteLifePhoto.message)
                        )
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}

extension MediaService {
    static public func extractFileName(
        url: String
    ) -> String? {
        if let url = URL(string: url) {
            return url.lastPathComponent
        }
        return nil
    }
}
