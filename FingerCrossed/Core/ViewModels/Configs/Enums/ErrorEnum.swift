//
//  ErrorEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import Foundation

public struct FCError {}

extension FCError {
    public enum VoiceMessage: Error {
        case unknown
        case downloadFailed
        case getPresignedUrlFailed
        case uploadS3ObjectFailed
        case deleteS3ObjectFailed
        case uploadFailed
        case updateUserFailed
    }
}
