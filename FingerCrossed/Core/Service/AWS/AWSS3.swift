//
//  AWSS3.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/11/23.
//

import Foundation

struct AWSS3 {
    
    private enum MediaType {
        case audio
        case image
    }
    
    private enum AWSError: Error {
        case networkError
        case permissionDenied
        case unknownError
        case dataMissingError
    }
        
    static public func uploadImage(
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
                        .image,
                        from: self.extractFilename(from: url)
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
    
    static public func uploadAudio(
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
                        .audio,
                        from: self.extractFilename(from: url)
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
    static private func uploadImageImpl(
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
    static private func uploadAudioImpl(
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
    
    static private func extractFilename(
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
    
    static private func parseCDNUrl(
        _ mediaType: MediaType,
        from fileName: String?
    ) -> URL? {
        guard let fileName else {
            return nil
        }
        switch mediaType {
        case .audio:
            let cdnUrl = "https://d2yydc9fog8bo7.cloudfront.net/audio/\(fileName)"
            return URL(string: cdnUrl)
        case .image:
            let cdnUrl = "https://d2yydc9fog8bo7.cloudfront.net/image/\(fileName)"
            return URL(string: cdnUrl)
        }
    }
}

extension AWSS3 {
    
    static public func deleteObject(
        presignedURL: String
    ) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            deleteObjectImpl(
                presignedURL: URL(string: presignedURL)!
            ) { result in
                switch result {
                case .success:
                    continuation.resume(returning: true)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    static private func deleteObjectImpl(
        presignedURL remoteURL: URL,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        var request = URLRequest(url: remoteURL)
        request.httpMethod = "DELETE"
        let deleteTask = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(
                    .failure(
                        NSError(
                            domain: "Invalid response",
                            code: 0,
                            userInfo: nil
                        )
                    )
                )
                return
            }
            
            // Successful deletion
            if httpResponse.statusCode == 204 {
                completion(.success(()))
            } else {
                let error = NSError(
                    domain: "Delete failed with status code \(httpResponse.statusCode)",
                    code: httpResponse.statusCode,
                    userInfo: nil
                )
                completion(.failure(error))
            }
        }
        deleteTask.resume()
    }

}
