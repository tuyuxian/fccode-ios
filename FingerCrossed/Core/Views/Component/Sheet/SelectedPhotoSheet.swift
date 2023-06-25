//
//  SelectedPhotoSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/2/23.
//

import SwiftUI
import Photos

struct SelectedPhotoSheet: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    @StateObject var limitedPhotoPicker = PhotoPickerViewModel()
    
    @Binding var selectedImage: UIImage?
    /// Flag for photo library permission Confirmation Dialog
    @State private var showPhotoPermissionConfirmationDialog: Bool = false
    
    var body: some View {
        Sheet(
            size: [.fraction(0.6)],
            header: {
                VStack(spacing: 0) {
                    Text("Selected Photos")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                    Text("Finger Crossed has access to the following photos")
                        .fontTemplate(.captionMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 14)
                }
            },
            content: {
                LimitedPhotoPicker(isPresented: $limitedPhotoPicker.showLimitedPicker)
                    .frame(width: 0, height: 0)
                    .padding(.top, 30)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        Button {
                            showPhotoPermissionConfirmationDialog.toggle()
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 110, height: 110)
                                .foregroundColor(Color.yellow100)
                                .overlay(alignment: .center) {
                                    FCIcon.picture
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.white)
                                        .frame(width: 67.69, height: 67.69)
                                }
                        }
                        
                        if !limitedPhotoPicker.fetchedPhotos.isEmpty {
                            ForEach(limitedPhotoPicker.fetchedPhotos) { photo in
                                ThumbnailView(photo: photo)
                                    .onTapGesture {
                                        limitedPhotoPicker.extractImage(asset: photo.photoAsset)
                                        presentationMode.wrappedValue.dismiss()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            if limitedPhotoPicker.extractUIImage != nil {
                                                selectedImage = limitedPhotoPicker.extractUIImage
                                            }
                                        }
                                        
                                    }
                            }
                        }
                    }
                    .onAppear {
                        limitedPhotoPicker.fetchPhotos()
                    }
                    .confirmationDialog(
                        "", isPresented: $showPhotoPermissionConfirmationDialog
                    ) {
                        Button(
                            "Cancel",
                            role: .cancel
                        ) {
                            showPhotoPermissionConfirmationDialog.toggle()
                        }
                        Button(
                            "Select more photos"
                        ) {
                            limitedPhotoPicker.openLimitedPicker()
                        }
                        Button(
                            "Change settings"
                        ) {
                            UIApplication.shared.open(
                                URL(string: UIApplication.openSettingsURLString)!
                            )
                        }
                    } message: {
                        Text(limitedPhotoPicker.photoPermissionComfirmationDialogMessage)
                    }
                }
            },
            footer: {})
    }
}

struct ThumbnailView: View {
    var photo: PhotoAsset
    
    var body: some View {
        Image(uiImage: photo.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 110, height: 110)
            .cornerRadius(16)
    }
}

private var uiImage: Binding<UIImage?> {
    Binding.constant(UIImage())
}

struct SelectedPhotoSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPhotoSheet(selectedImage: uiImage)
    }
}
