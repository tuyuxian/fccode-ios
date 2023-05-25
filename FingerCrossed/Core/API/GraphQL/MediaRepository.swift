//
//  MediaRepository.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/24/23.
//

import Foundation
import GraphQLAPI

class MediaRepository {
    
    public func getPresignedPutUrl(
        _ sourceType: GraphQLEnum<GraphQLAPI.MediaSourceType>,
        completion: @escaping (String?, String?) -> ()
    ) {
        Network.shared.apollo.fetch(
            query: GetS3PresignedPutUrlQuery(sourceType: sourceType),
            cachePolicy: .fetchIgnoringCacheCompletely
        ) { result in
            switch result {
            case .success(let data):
                switch data.data?.getS3PresignedPutUrl.statusCode {
                case 200:
                    completion(data.data?.getS3PresignedPutUrl.url, nil)
                case 401:
                    completion(nil, data.data?.getS3PresignedPutUrl.message)
                default:
                    completion(nil, data.data?.getS3PresignedPutUrl.message)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
