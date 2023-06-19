//
//  LimitedPhotoPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/7/23.
//

import SwiftUI
import Photos

struct LimitedPhotoPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if isPresented {
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: uiViewController)
            DispatchQueue.main.async {
                isPresented = false
            }
        }
    }
}
