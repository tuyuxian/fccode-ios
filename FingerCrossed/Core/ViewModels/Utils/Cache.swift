//
//  Cache.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/20/23.
//

import Foundation

extension URLSession {
    static let imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        return .init(configuration: config)
    }()
    
    static let audioSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .audioCache
        return .init(configuration: config)
    }()
}

extension URLCache {
    static let imageCache: URLCache = {
        .init(
            memoryCapacity: 50 * 1024 * 1024, // 50 MB
            diskCapacity: 100 * 1024 * 1024 // 100 MB
        )
    }()
    
    static let audioCache: URLCache = {
        .init(
            memoryCapacity: 20 * 1024 * 1024, // 20 MB
            diskCapacity: 30 * 1024 * 1024 // 30 MB
        )
    }()
}
