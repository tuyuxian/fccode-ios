//
//  PhotoPickerSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/28/23.
//

import SwiftUI
import Photos

struct PhotoPickerSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var photoLibraryDataManager = PhotoLibraryDataManager()
    
    @Binding var selectedImage: UIImage?
        
    var libraryView: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(
                    repeating: .init(.flexible(), spacing: 6),
                    count: 3
                ),
                spacing: 6
            ) {
                ForEach(
                    photoLibraryDataManager.results,
                    id: \.self
                ) { asset in
                    ThumbnailView(
                        pldm: photoLibraryDataManager,
                        assetLocalId: asset.localIdentifier
                    )
                    .onTapGesture {
                        Task {
                            do {
                                let uiImage = try await photoLibraryDataManager.fetchImage(
                                    byLocalIdentifier: asset.localIdentifier,
                                    targetSize: PHImageManagerMaximumSize
                                )
                                selectedImage = uiImage
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        Sheet(
            size: [.medium, .large],
            hasFooter: false,
            header: {
                VStack(spacing: 4) {
                    Text("Selected Photos")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                    Text("Finger Crossed has access to the following photos")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.text)
                        .frame(height: 16)
                }
                .padding(.horizontal, 24)
            },
            content: {
                libraryView
                    .padding(.top, 6)
                    .padding(.horizontal, 24)
                    .onAppear {
                        photoLibraryDataManager.fetchAllPhotos()
                    }
            },
            footer: {}
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct PhotoPickerSheet_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerSheet(selectedImage: .constant(UIImage()))
    }
}

extension PhotoPickerSheet {
    
    struct ThumbnailView: View {
        
        @ObservedObject var pldm: PhotoLibraryDataManager
        
        @State private var image: Image?
        
        private var assetLocalId: String
            
        init(
            pldm: PhotoLibraryDataManager,
            assetLocalId: String
        ) {
            self.pldm = pldm
            self.assetLocalId = assetLocalId
        }
        
        var body: some View {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.gray)
                .overlay {
                    if let image = image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                            .clipped()
                    }
                }

            .frame(
                width: (UIScreen.main.bounds.size.width - 60)/3,
                height: (UIScreen.main.bounds.size.width - 60)/3
            )
            .clipped()
            .cornerRadius(16)
            .aspectRatio(1, contentMode: .fit)
            .drawingGroup()
            .task {
                await loadImageAsset()
            }
            .onDisappear {
                image = nil
            }
        }
        
        private func loadImageAsset(
            targetSize: CGSize = CGSize(width: 300, height: 300)
        ) async {
            guard let uiImage = try? await pldm.fetchImage(
                byLocalIdentifier: assetLocalId,
                targetSize: targetSize
            ) else {
                image = nil
                return
            }
            image = Image(uiImage: uiImage)
        }
    }
    
}
