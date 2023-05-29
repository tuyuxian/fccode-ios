//
//  MediaRepository.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import GraphQLAPI

class MediaRepository {
    
    public class func getPresignedPutUrl(
        _ sourceType: GraphQLEnum<GraphQLAPI.MediaSourceType>
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
                    case 401:
                        continuation.resume(throwing: GraphQLError.customError(data.getS3PresignedPutUrl.message))
                    default:
                        continuation.resume(throwing: GraphQLError.customError(data.getS3PresignedPutUrl.message))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
