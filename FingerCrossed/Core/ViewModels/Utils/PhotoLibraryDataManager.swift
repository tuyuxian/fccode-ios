//
//  PhotoLibraryDataManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/28/23.
//

import Photos
import UIKit

@MainActor
class PhotoLibraryDataManager: ObservableObject {
    
    @Published var results = PHFetchResultCollection(fetchResult: .init())
    
    var imageCachingManager = PHCachingImageManager()
}

extension PhotoLibraryDataManager {
    
    public func fetchAllPhotos() {
        self.imageCachingManager.allowsCachingHighQualityImages = false
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeHiddenAssets = false
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        self.results.fetchResult = PHAsset.fetchAssets(
            with: .image,
            options: fetchOptions
        )
    }
    
    public func fetchImage(
        byLocalIdentifier localId: String,
        targetSize: CGSize = PHImageManagerMaximumSize,
        contentMode: PHImageContentMode = .default
    ) async throws -> UIImage? {
        let results = PHAsset.fetchAssets(
            withLocalIdentifiers: [localId],
            options: nil
        )
        guard let asset = results.firstObject else {
            throw FCError.PhotoLibrary.queryError
        }
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.imageCachingManager.requestImage(
                for: asset,
                targetSize: targetSize,
                contentMode: contentMode,
                options: options,
                resultHandler: { image, info in
                    if let error = info?[PHImageErrorKey] as? Error {
                        continuation.resume(throwing: error)
                        return
                    }
                    continuation.resume(returning: image)
                }
            )
        }
    }

}

extension PhotoLibraryDataManager {
    
    typealias Element = PHAsset
    typealias Index = Int
    
    struct PHFetchResultCollection: RandomAccessCollection, Equatable {
        var fetchResult: PHFetchResult<PHAsset>
        var endIndex: Int { fetchResult.count }
        var startIndex: Int { 0 }

        subscript(
            position: Int
        ) -> PHAsset {
            fetchResult.object(at: fetchResult.count - position - 1)
        }
    }
    
}
