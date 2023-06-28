//
//  LifePhotoEditSheetViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import Foundation
import PhotosUI
import SwiftUI
import GraphQLAPI

@MainActor
class LifePhotoEditSheetViewModel: ObservableObject {
    
    @AppStorage("UserId") private var userId: String = ""

    /// View state
    @Published var currentView: Int = 0
    @Published var state: ViewStatus = .none
    @Published var isSatisfied: Bool = false
    @Published var isKeyboardShowUp: Bool = false
    @Published var selectedTag: LifePhotoEditSheet.CropRatio = .ratio1
    @Published var caption: String = ""
    
    /// Offset
    @Published var currentOffset: CGSize = .zero
    /// Scale
    @Published var currentScale: CGFloat = 1.0
    /// Alert
    @Published var fcAlert: FCAlert?
    
    let textLengthLimit: Int = 200

}

extension LifePhotoEditSheetViewModel {
    
    public func showAlert() {
        self.fcAlert = .info(
            type: .info,
            title: "Oopsie!",
            message: "Something went wrong.",
            dismissLabel: "Dismiss",
            dismissAction: {
                self.state = .none
                self.fcAlert = nil
            }
        )
    }
    
    // swiftlint: disable function_parameter_count
    public func save(
        data: Data?,
        caption: String,
        position: Int,
        ratio: Int,
        scale: Double,
        offsetX: Double,
        offsetY: Double
    ) async throws -> [LifePhoto] {
        self.state = .loading
        let url = try await MediaService.getPresignedPutUrl(.case(.image))
        guard let url = url else { throw FCError.LifePhoto.getPresignedUrlFailed }
        let remoteUrl = try await AWSS3.uploadImage(
            data,
            toPresignedURL: URL(string: url)!
        )
        let (statusCode, lifePhotos) = try await MediaService.createLifePhoto(
            userId: self.userId,
            input: CreateLifePhotoInput(
                contentURL: remoteUrl.absoluteString,
                caption: .some(caption),
                position: position,
                ratio: ratio,
                scale: scale,
                offsetX: offsetX,
                offsetY: offsetY
            )
        )
        guard statusCode == 200 else {
            throw FCError.LifePhoto.createLifePhotoFailed
        }
        self.state = .complete
        return lifePhotos
    }
    
    public func update(
        lifePhotoId: String,
        caption: String,
        ratio: Int,
        scale: Double,
        offsetX: Double,
        offsetY: Double
    ) async throws -> [LifePhoto] {
        self.state = .loading
        let (statusCode, lifePhotos) = try await MediaService.updateLifePhoto(
            userId: self.userId,
            lifePhotoId: lifePhotoId,
            input: UpdateLifePhotoInput(
                caption: .some(caption),
                ratio: .some(ratio),
                scale: .some(scale),
                offsetX: .some(offsetX),
                offsetY: .some(offsetY)
            )
        )
        guard statusCode == 200 else {
            throw FCError.LifePhoto.updateLifePhotoFailed
        }
        self.state = .complete
        return lifePhotos
    }
    // swiftlint: enable function_parameter_count
    
}
