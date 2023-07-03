//
//  PhotoPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/31/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPickerOld: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> some UIViewController {
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    configuration.filter = .images // filter only to images
    configuration.selectionLimit = 1 // ignore limit

    let photoPickerViewController = PHPickerViewController(configuration: configuration)
    photoPickerViewController.delegate = context.coordinator // Use Coordinator for delegation
    return photoPickerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
      
    // Create the Coordinator, in this case it is a way to communicate with the PHPickerViewController
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPickerOld

        init(_ parent: PhotoPickerOld) {
          self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [self] newImage, error in
                        if let error = error {
                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            DispatchQueue.main.async {
                                print("size: \(image.size)")
                                self.parent.selectedImage = image
                            }
                            
                        }
                    }
                } else {
                    print("Can't load asset")
                }
            }
        }
    }
}
