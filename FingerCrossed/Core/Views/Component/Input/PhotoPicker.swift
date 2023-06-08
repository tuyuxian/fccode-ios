//
//  PhotoPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/31/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool // close the modal view

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
        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
          self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //        parent.pickerResult.removeAll() // remove previous pictures from the main view
            picker.dismiss(animated: true)
            // unpack the selected items
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                        if let error = error {
                            print("Can't load image \(error.localizedDescription)")
                        } else if let image = newImage as? UIImage {
                            // Add new image and pass it back to the main view
                            self?.parent.selectedImage = image
                            self?.parent.imageData = image.jpegData(compressionQuality: 0.9)
                            //                      self?.parent.pickerResult.append(image)
                        }
                    }
                } else {
                    print("Can't load asset")
                }
            }
        }
    }
}
