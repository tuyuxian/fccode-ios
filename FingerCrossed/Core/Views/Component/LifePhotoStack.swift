//
//  LifePhotoStack.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoStack: View {
    
    @StateObject var lifePhotoData = LifePhotoViewModel()

    var body: some View {
        GeometryReader { proxy in
            LazyHStack(spacing: 14) {
                ForEach(lifePhotoData.lifePhotos[0...0]) { lifePhoto in
                    LifePhotoButton(
                        lifePhoto: lifePhoto,
                        halfSize: (proxy.size.width - 42)/4,
                        fullSize: (proxy.size.width - 14)/2,
                        config: lifePhotoData
                     )
                    .onDrag({
                        lifePhotoData.currentDragLifePhoto = lifePhoto
                        return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                    })
                    .onDrop(
                        of: [.url],
                        delegate:
                            DropViewDelegate(
                                lifePhoto: lifePhoto,
                                lifePhotoData: lifePhotoData
                            )
                    )
                }
                LazyVStack(spacing: 14) {
                    LazyHStack(spacing: 14) {
                        ForEach(lifePhotoData.lifePhotos[1...2]) { lifePhoto in
                            if lifePhoto.photoUrl != "" {
                                LifePhotoButton(
                                    lifePhoto: lifePhoto,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2,
                                    config: lifePhotoData
                                )
                                .onDrag({
                                    lifePhotoData.currentDragLifePhoto = lifePhoto
                                    return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                                })
                                .onDrop(
                                    of: [.url],
                                    delegate:
                                        DropViewDelegate(
                                            lifePhoto: lifePhoto,
                                            lifePhotoData: lifePhotoData
                                        )
                                )
                            } else {
                                LifePhotoButton(
                                    lifePhoto: lifePhoto,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2,
                                    config: lifePhotoData
                                )
                            }
                        }
                    }
                    LazyHStack(spacing: 14) {
                        ForEach(lifePhotoData.lifePhotos[3...4]) { lifePhoto in
                            if lifePhoto.photoUrl != "" {
                                LifePhotoButton(
                                    lifePhoto: lifePhoto,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2,
                                    config: lifePhotoData
                                )
                                .onDrag({
                                    lifePhotoData.currentDragLifePhoto = lifePhoto
                                    return NSItemProvider(contentsOf: URL(string: "\(lifePhoto.id)")!)!
                                })
                                .onDrop(
                                    of: [.url],
                                    delegate:
                                        DropViewDelegate(
                                            lifePhoto: lifePhoto,
                                            lifePhotoData: lifePhotoData
                                        )
                                )
                            } else {
                                LifePhotoButton(
                                    lifePhoto: lifePhoto,
                                    halfSize: (proxy.size.width - 42)/4,
                                    fullSize: (proxy.size.width - 14)/2,
                                    config: lifePhotoData
                                )
                            }
                        }
                    }
                }
                .frame(width: (proxy.size.width - 14)/2, height: (proxy.size.width - 14)/2)
            }
            .frame(width: proxy.size.width, height: (proxy.size.width - 14)/2)
            .sheet(isPresented: $lifePhotoData.showEditSheet) {
                LifePhotoActionSheet(config: lifePhotoData)
            }
        }
    }
}

struct LifePhotoStack_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoStack()
    }
}

struct DropViewDelegate: DropDelegate {
    
    var lifePhoto: LifePhoto
    
    var lifePhotoData: LifePhotoViewModel
    
    func performDrop(
        info: DropInfo
    ) -> Bool {
        return true
    }
    
    func dropEntered(
        info: DropInfo
    ) {
        let fromIndex = lifePhotoData.lifePhotos.firstIndex { (lifePhoto) -> Bool in
            return lifePhoto.id == lifePhotoData.currentDragLifePhoto?.id
        } ?? 0
        
        let toIndex = lifePhotoData.lifePhotos.firstIndex { (lifePhoto) -> Bool in
            return lifePhoto.id == self.lifePhoto.id
        } ?? 0
        
        if fromIndex != toIndex {
            let fromLifePhoto = lifePhotoData.lifePhotos[fromIndex]
            lifePhotoData.lifePhotos[fromIndex] = lifePhotoData.lifePhotos[toIndex]
            lifePhotoData.lifePhotos[fromIndex].position = fromIndex
            lifePhotoData.lifePhotos[toIndex] = fromLifePhoto
            lifePhotoData.lifePhotos[toIndex].position = toIndex
        }
    }
    
    func dropUpdated(
        info: DropInfo
    ) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}
