//
//  SelectedPhotoListSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/2/23.
//

import SwiftUI
import Photos

struct SelectedPhotoListSheet: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    @StateObject var limitedPhotoPicker = PhotoPickerViewModel()
    
    @Binding var selectedImage: UIImage?
    @Binding var imageData: Data?
    
    var body: some View {
        Sheet(
            size: [.fraction(0.6)],
            showDragIndicator: true,
            hasHeader: false,
            content: {
                VStack(spacing: 0) {
                    Text("Selected Photos")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                    Text("Fingercrossed has access to the following photos")
                        .fontTemplate(.captionMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 14)
                }
                .padding(.top, 15) // 30 - 15
                .padding(.bottom, 30)
                
                LimitedPhotoPicker(isPresented: $limitedPhotoPicker.showLimitedPicker)
                    .frame(width: 0, height: 0)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        Button {
                            limitedPhotoPicker.openLimitedPicker()
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 110, height: 110)
                                .foregroundColor(Color.yellow100)
                                .overlay(alignment: .center) {
                                    Image("ManagePicture")
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
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            if limitedPhotoPicker.extractUIImage != nil {
                                                selectedImage = limitedPhotoPicker.extractUIImage
                                                imageData = limitedPhotoPicker.extractUIImage.jpegData(compressionQuality: 0.9)
                                            }
                                        }
                                        
                                    }
                            }
                        }
                    }
                    .onAppear {
                        limitedPhotoPicker.fetchPhotos()
                    }
                    .alert(isPresented: $limitedPhotoPicker.showNotImageAlert) {
                        Alert(
                            title:
                                Text(limitedPhotoPicker.notImageAlertTitle)
                                .font(Font.system(size: 18, weight: .medium)),
                            message:
                                Text(limitedPhotoPicker.notImageAlertMessage)
                                .font(Font.system(size: 12, weight: .medium)),
                            dismissButton:
                                    .cancel(Text("ok"))
                        )
                    }
                }
            },
            footer: {})
    }
}

struct ThumbnailView: View {
    var photo: Asset
    
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

private var data: Binding<Data?> {
    Binding.constant(Data())
}

struct SelectedPhotoListSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPhotoListSheet(selectedImage: uiImage, imageData: data)
    }
}
