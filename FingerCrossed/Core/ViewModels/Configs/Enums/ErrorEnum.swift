//
//  ErrorEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import Foundation

public struct FCError {}

extension FCError {
    
    public enum User: Error {
        case unknown
        case getUserFailed
        case updateUserFailed
    }
    
    public enum VoiceMessage: Error {
        case unknown
        case extractFilenameFailed
        case downloadFailed
        case getPresignedUrlFailed
        case uploadS3ObjectFailed
        case deleteS3ObjectFailed
        case uploadFailed
        case updateUserFailed
    }
    
    public enum SelfIntro: Error {
        case unknown
        case updateUserFailed
    }
    
    public enum LifePhoto: Error {
        
    }
}
