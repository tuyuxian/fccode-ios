//
//  LifePhoto.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import Foundation

struct LifePhoto: Identifiable, Equatable {
    let id: UUID
    var photoUrl: String
    var caption: String
    var position: Int
    
    init(
        id: UUID = UUID(),
        photoUrl: String,
        caption: String,
        position: Int
    ) {
        self.id = id
        self.photoUrl = photoUrl
        self.caption = caption
        self.position = position
    }
}

class LifePhotoViewModel: ObservableObject {
    @Published var lifePhotos = [
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=6", caption: "", position: 0),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=7", caption: "", position: 1),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=8", caption: "", position: 2),
        LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=9", caption: "", position: 3),
        LifePhoto(photoUrl: "", caption: "", position: 4)
    ]
    
    @Published var currentDragLifePhoto: LifePhoto?
    
    @Published var hasLifePhoto: Bool = false
    
    @Published var showEditSheet: Bool = false
    
    @Published var currentLifePhotoCount: Int = 3
    
    @Published var imageScale: CGFloat = 1
    
    @Published var selectedLifePhoto: LifePhoto?
    
}
