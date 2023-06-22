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

class LifePhotoEditSheetViewModel: ObservableObject {
    
    @AppStorage("UserId") private var userId: String = ""
    
    enum CurrentView: Int {
        case lifePhoto
        case caption
    }
    
    enum Transition: Int {
        case forward
        case backward
    }
    
    @Published var transition: Transition = .forward
    @Published var switchView: CurrentView = .lifePhoto
        
    /// View state
    @Published var state: ViewStatus = .none
    @Published var isSatisfied: Bool = false
    @Published var isKeyboardShowUp: Bool = false
    @Published var selectedTag: Int = 0

    @Published var bottomPadding: CGFloat = 0
    @Published var currentOffset: CGSize = .zero
    @Published var uiImage: UIImage = UIImage()
    @Published var newUIImage: UIImage = UIImage()
    @Published var caption: String = ""
    
    let textLengthLimit: Int = 200
    
}

extension LifePhotoEditSheetViewModel {
    
    public func continueOnTap() {
        transition = .forward
        switchView = .caption
    }
    
    // swiftlint: disable function_parameter_count
    @MainActor
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
    
    @MainActor
    public func update(
        lifePhotoId: String,
        caption: String,
        position: Int,
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
                position: .some(position),
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

// MARK: Helper function
extension LifePhotoEditSheetViewModel {
    
//    public func imageHeight() -> CGFloat {
//        switch self.selectedTag {
//        case 0:
//            return (UIScreen.main.bounds.width - 48)/16 * 9
//        case 1:
//            return UIScreen.main.bounds.width - 48
//        case 2:
//            return (UIScreen.main.bounds.width - 48)/4 * 3
//        case 3:
//            return UIScreen.main.bounds.width - 48
//        default:
//            return UIScreen.main.bounds.width - 48
//        }
//    }
    
    public func imageHeight(width: CGFloat) -> CGFloat {
        switch self.selectedTag {
        case 0:
            return (width - 48) * 9 / 16
        case 1:
            return (width - 48) * 16 / 9
        case 2:
            return (width - 48) * 3 / 4
        case 3:
            return (width - 48) * 4 / 3
        default:
            return (width - 48) * 9 / 16
        }
    }
    
    public func imageWidth() -> CGFloat {
        switch self.selectedTag {
        case 0:
            return UIScreen.main.bounds.width - 48
        case 1:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        case 2:
            return UIScreen.main.bounds.width - 48
        case 3:
            return (UIScreen.main.bounds.width - 48)/4 * 3
        default:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        }
    }
}
