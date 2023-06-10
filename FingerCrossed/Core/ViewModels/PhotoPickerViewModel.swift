//
//  PhotoPickerViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/5/23.
//

import SwiftUI
import PhotosUI

class PhotoPickerViewModel: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    @Published var showPhotoPicker = false
    
    @Published var showLimitedPicker = false
    
    @Published var showNotImageAlert = false
    
    @Published var fetchedPhotos: [PhotoAsset] = []
    
    @Published var allPhotos: PHFetchResult<PHAsset>!
    
    @Published var extractUIImage: UIImage!
    
    let notImageAlertTitle: String = "Only image is allowed"
    
    let notImageAlertMessage: String = "In this situation, only image is allowed in Finger Crossed."
    
    let photoPermissionComfirmationDialogMessage: String = "To access all of your photos in Finger Crossed, allow access to your full library in device setting."
    
    func openLimitedPicker() {
        if fetchedPhotos.isEmpty {
            fetchPhotos()
        }
        
        showLimitedPicker.toggle()
        
        PHPhotoLibrary.shared().register(self)
    }
        
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let _ = allPhotos else { return }
        
        if let updates = changeInstance.changeDetails(for: allPhotos) {
            
            let updatedPhotos = updates.fetchResultAfterChanges
            
            updatedPhotos.enumerateObjects { [self] asset, index, _ in
                if !allPhotos.contains(asset) {
                    if asset.mediaType == .image {
                        getImageFromAsset(asset: asset, size: CGSize(width: 180, height: 180)) { image in
                            DispatchQueue.main.async {
                                self.fetchedPhotos.append(PhotoAsset(photoAsset: asset, image: image))
                            }
                        }
                    } else {
                        showNotImageAlert.toggle()
                    }
                }
            }
            
            allPhotos.enumerateObjects { asset, index, _ in
                if !updatedPhotos.contains(asset) {
                    DispatchQueue.main.async {
                        self.fetchedPhotos.removeAll { result -> Bool in
                            return result.photoAsset == asset
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.allPhotos = updatedPhotos
            }
        }
    }
    
    func fetchPhotos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        options.includeHiddenAssets = false
        
        let fetchResults = PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects { [self] asset, index, _ in
            
            getImageFromAsset(asset: asset, size: CGSize(width: 180, height: 180)) { [self] image in
                fetchedPhotos.append(PhotoAsset(photoAsset: asset, image: image))
            }
            
        }
    }
    
    func getImageFromAsset(asset: PHAsset, size: CGSize, completion: @escaping (UIImage) -> ()) {
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.isSynchronous = false
        
        let sizeFactor = UIScreen.main.scale
        let deviceSize = UIScreen.main.nativeBounds.size
        let size = CGSize(width: deviceSize.width * sizeFactor, height: deviceSize.height * sizeFactor)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { image, _ in
            guard let resizeImage = image else { return }
            
            completion(resizeImage)
        }
    }
    
    func extractImage(asset: PHAsset) {
        getImageFromAsset(asset: asset, size: PHImageManagerMaximumSize) { image in
            DispatchQueue.main.async {
                 self.extractUIImage = image
            }
        }
    }
}

struct PhotoAsset: Identifiable {
    var id: String = UUID().uuidString
    var photoAsset: PHAsset
    var image: UIImage
}
