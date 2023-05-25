//
//  AWSS3.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/11/23.
//

import Foundation

class AWSS3 {
    
    private var continuation: CheckedContinuation<URL?, Error>?
    
    public func uploadImage(
        _ data: Data?,
        toPresignedURL remoteURL: URL
    ) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            uploadImageImpl(
                data,
                toPresignedURL: remoteURL
            ) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data!)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func uploadAudio(
        _ path: URL,
        toPresignedURL remoteURL: URL
    ) async -> Result<URL?, Error> {
        return await withCheckedContinuation { continuation in
            uploadAudioImpl(
                path,
                toPresignedURL: remoteURL
            ) { (result) in
                switch result {
                case .success:
                    print("Upload completed")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                continuation.resume(returning: result)
            }
        }
    }
    
    /// Creates a upload request for uploading the specified file to a presigned remote URL
    ///
    /// - Parameters:
    ///     - data: The data file to upload.
    ///     - remoteURL: The presigned URL.
    ///     - completion: The completion handler to call when the upload request is complete.
    private func uploadImageImpl(
        _ data: Data?,
        toPresignedURL remoteURL: URL,
        completion: @escaping (Result<URL?, Error>) -> Void
    ) {
        var request = URLRequest(url: remoteURL)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "PUT"
        let uploadTask = URLSession.shared.uploadTask(
            with: request,
            from: data,
            completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard response != nil, data != nil else {
                    completion(.success(nil))
                    return
                }
            }
        )
        uploadTask.resume()
    }
    
    /// Creates a upload request for uploading the specified file to a presigned remote URL.
    ///
    /// - Parameters:
    ///     - path: The file path to upload.
    ///     - remoteURL: The presigned URL.
    ///     - completion: The completion handler to call when the upload request is complete.
    private func uploadAudioImpl(
        _ path: URL,
        toPresignedURL remoteURL: URL,
        completion: @escaping (Result<URL?, Error>) -> Void
    ) {
        var request = URLRequest(url: remoteURL)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "PUT"
        let uploadTask = URLSession.shared.uploadTask(
            with: request,
            fromFile: path,
            completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard response != nil, data != nil else {
                    completion(.success(nil))
                    return
                }
            }
        )
        uploadTask.resume()
    }
}
