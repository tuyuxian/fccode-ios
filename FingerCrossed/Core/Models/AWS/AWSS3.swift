//
//  AWSS3.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/11/23.
//

import Foundation

class AWSS3 {
    
    /// Creates a upload request for uploading the specified file to a presigned remote URL
    ///
    /// - Parameters:
    ///     - data: The data file to upload.
    ///     - remoteURL: The presigned URL
    ///     - completion: The completion handler to call when the upload request is complete.
    
    class func upload(
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
            print("Successfully upload to S3")
        })
        uploadTask.resume()
    }
    
//    private func upload(_ fileURL: URL, toPresignedURL remoteURL: URL) async -> Result<URL?, Error> {
//      return await withCheckedContinuation { continuation in
//        upload(fileURL, toPresignedURL: remoteURL) { (result) in
//          switch result {
//          case .success(let url):
//              print("File uploaded: ", url)
//          case .failure(let error):
//              print("Upload failed: ", error.localizedDescription)
//          }
//          continuation.resume(returning: result)
//        }
//      }
//    }

}
