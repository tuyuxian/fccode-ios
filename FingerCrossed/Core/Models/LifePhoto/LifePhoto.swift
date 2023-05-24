//
//  LifePhoto.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation
import UIKit

struct LifePhoto: Identifiable, Equatable {
    let id: UUID
    var photoUrl: String
    var caption: String
    var position: Int
    var scale: CGFloat
    var offset: CGSize
    
    init(
        id: UUID = UUID(),
        photoUrl: String,
        caption: String,
        position: Int,
        scale: CGFloat,
        offset: CGSize
    ) {
        self.id = id
        self.photoUrl = photoUrl
        self.caption = caption
        self.position = position
        self.scale = scale
        self.offset = offset
    }
}

class LifePhotoViewModel: ObservableObject {
    @Published var lifePhotos = [
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=6", caption: "", position: 0, scale: 1, offset: CGSize.zero),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=7", caption: "", position: 1, scale: 1, offset: CGSize.zero),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=8", caption: "", position: 2, scale: 1, offset: CGSize.zero),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=9", caption: "", position: 3, scale: 1, offset: CGSize.zero),
        LifePhoto(photoUrl: "", caption: "", position: 4, scale: 1, offset: CGSize.zero)
    ]
    
    @Published var currentDragLifePhoto: LifePhoto?
    
    @Published var hasLifePhoto: Bool = false
    
    @Published var showEditSheet: Bool = false
    
    @Published var currentLifePhotoCount: Int = 3
    
    @Published var imageScale: CGFloat = 1
    
    @Published var imageOffset = CGSize.zero
    
    @Published var selectedLifePhoto: LifePhoto?
    
    @Published var newUIImage: UIImage = UIImage()
    
    @Published var cropCGRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @Published var cropCGImage: CGImage = UIImage(systemName: "circle.fill")!.cgImage!
    
}
