//
//  LifePhotoButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct LifePhotoButton: View {
    
    let id = UUID()
    
    @Binding var lifePhoto: LifePhoto?
    
    @Binding var isEditable: Bool
    
    @Binding var showEditSheet: Bool
    
    @Binding var hasLifePhoto: Bool
    
    @Binding var selectedLifePhoto: LifePhoto?
            
    var body: some View {
        Rectangle()
            .fill(
                isEditable
                ? Color.yellow100
                : Color.yellow20
            )
            .aspectRatio(contentMode: .fill)
            .overlay(
                AsyncImage(
                    url: URL(string: lifePhoto?.contentUrl ?? ""),
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        if isEditable {
                            FCAddPhotoIcon()
                        } else {
                            FCPhotoIcon()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        if isEditable {
                            FCAddPhotoIcon()
                        } else {
                            FCPhotoIcon()
                        }
                    @unknown default:
                        if isEditable {
                            FCAddPhotoIcon()
                        } else {
                            FCPhotoIcon()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16))
                .onTapGesture {
                    showEditSheet = true
                    selectedLifePhoto = lifePhoto
                    hasLifePhoto = lifePhoto != nil
                }
            )
            .clipped()
            .cornerRadius(16)
    }
}

struct LifePhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        Grid {
            GridRow {
                LifePhotoButton(
                    lifePhoto: .constant(LifePhoto.MockLifePhoto),
                    isEditable: .constant(true),
                    showEditSheet: .constant(false),
                    hasLifePhoto: .constant(true),
                    selectedLifePhoto: .constant(LifePhoto.MockLifePhoto)
                )
                LifePhotoButton(
                    lifePhoto: .constant(nil),
                    isEditable: .constant(true),
                    showEditSheet: .constant(false),
                    hasLifePhoto: .constant(false),
                    selectedLifePhoto: .constant(LifePhoto.MockLifePhoto)
                )
            }
        }
        .frame(height: 164)
        .padding(.horizontal, 24)
    }
}

private struct FCPhotoIcon: View {
    var body: some View {
        FCIcon.picture
            .resizable()
            .renderingMode(.template)
            .frame(width: 46.15, height: 46.15)
            .foregroundColor(Color.white)
    }
}

private struct FCAddPhotoIcon: View {
    var body: some View {
        FCIcon.addPicture
            .resizable()
            .renderingMode(.template)
            .frame(width: 46.15, height: 46.15)
            .foregroundColor(Color.white)
    }
}
