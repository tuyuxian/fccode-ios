//
//  Camera.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/24/23.
//

import SwiftUI
import PhotosUI
import UIKit

struct Camera: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedImage: UIImage?
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<Camera>
    ) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<Camera>
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: Camera

        init(_ parent: Camera) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
    }
}
