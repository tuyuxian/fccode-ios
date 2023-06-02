//
//  AWSS3.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/11/23.
//

import Foundation

class AWSS3 {
    
    private enum AWSError: Error {
        case networkError
        case permissionDenied
        case unknownError
        case dataMissingError
    }
        
    public func uploadImage(
        _ data: Data?,
        toPresignedURL remoteURL: URL
    ) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            guard let data = data else {
                continuation.resume(throwing: AWSError.dataMissingError)
                return
            }
            uploadImageImpl(
                data,
                toPresignedURL: remoteURL
            ) { result in
                switch result {
                case .success(let url):
                    guard let url else {
                        continuation.resume(throwing: AWSError.networkError)
                        return
                    }
                    let cdnUrl = self.parseCDNUrl(
                        from: self.extractFilename(
                            from: url
                        )
                    )
                    guard let cdnUrl else {
                        continuation.resume(throwing: AWSError.unknownError)
                        return
                    }
                    continuation.resume(returning: cdnUrl)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func uploadAudio(
        _ path: URL,
        toPresignedURL remoteURL: URL
    ) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            uploadAudioImpl(
                path,
                toPresignedURL: remoteURL
            ) { result in
                switch result {
                case .success(let url):
                    guard let url else {
                        continuation.resume(throwing: AWSError.networkError)
                        return
                    }
                    let cdnUrl = self.parseCDNUrl(
                        from: self.extractFilename(
                            from: url
                        )
                    )
                    guard let cdnUrl else {
                        continuation.resume(throwing: AWSError.unknownError)
                        return
                    }
                    continuation.resume(returning: cdnUrl)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Creates a upload request for uploading the image file to a presigned remote URL
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
            completionHandler: { _, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(response?.url))
            }
        )
        uploadTask.resume()
    }

    /// Creates a upload request for uploading the audio file to a presigned remote URL.
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
            completionHandler: { _, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(response?.url))
            }
        )
        uploadTask.resume()
    }
    
    private func extractFilename(
        from url: URL
    ) -> String? {
        let pattern = "(?<=\\/)[^\\/]+(\\.jpg|\\.m4a)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }
        let urlString = url.absoluteString
        let range = NSRange(urlString.startIndex..<urlString.endIndex, in: urlString)
        
        if let match = regex.firstMatch(
            in: urlString,
            options: [], range: range
        ) {
            return String(urlString[Range(match.range, in: urlString)!])
        }
        
        return nil
    }
    
    private func parseCDNUrl(
        from fileName: String?
    ) -> URL? {
        guard let fileName else {
            return nil
        }
        let cdnUrl = "https://d2yydc9fog8bo7.cloudfront.net/\(fileName)"
        
        return URL(string: cdnUrl)
    }
}
