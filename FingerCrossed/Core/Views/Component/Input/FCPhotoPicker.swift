//
//  FCPhotoPicker.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/28/23.
//

import SwiftUI
import PhotosUI

struct FCPhotoPicker<Content: View>: View {
    
    @State private var selectedItem: PhotosPickerItem?
    
    @Binding var selectedImage: UIImage?
    
    @State var action: (() -> Void)?
    
    @ViewBuilder var content: Content
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) { content }
        .onChange(of: selectedItem) { val in
            Task {
                if let data = try? await val?.loadTransferable(
                    type: Data.self
                ) {
                    selectedImage = UIImage(data: data)
                    action?()
                }
            }
        }
    }
    
}
