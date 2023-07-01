//
//  ErrorEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

public struct FCError {}

extension FCError {
    
    public enum User: Error {
        case unknown
        case getUserFailed
        case updateUserFailed
    }
    
}

extension FCError {
    
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
    
}

extension FCError {
    
    public enum SelfIntro: Error {
        case unknown
        case updateUserFailed
    }
    
}
    
extension FCError {
    
    public enum LifePhoto: Error {
        case unknown
        case extractFilenameFailed
        case downloadFailed
        case getPresignedUrlFailed
        case uploadS3ObjectFailed
        case deleteS3ObjectFailed
        case uploadFailed
        case createLifePhotoFailed
        case updateLifePhotoFailed
        case updateUserFailed
    }
    
}

extension FCError {
    
    public enum PhotoLibrary: Error {
        case unknown
        case queryError
    }
    
}
