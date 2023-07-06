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
    
    var action: () -> Void = {}
                        
    var body: some View {
        Rectangle()
            .fill(
                isEditable
                ? Color.yellow100
                : Color.yellow20
            )
            .aspectRatio(contentMode: .fill)
            .overlay(
                Group {
                    if let url = lifePhoto?.contentUrl {
                        FCAsyncImage(
                            url: URL(string: url)!
                        )
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .id(UUID())
                    } else {
                        if isEditable {
                            FCAddPhotoIcon()
                        } else {
                            FCPhotoIcon()
                        }
                    }
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .cornerRadius(16)
            .onTapGesture {
                action()
            }
    }
}

struct LifePhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        Grid {
            GridRow {
                LifePhotoButton(
                    lifePhoto: .constant(LifePhoto.MockLifePhoto),
                    isEditable: .constant(true),
                    action: {}
                )
                LifePhotoButton(
                    lifePhoto: .constant(nil),
                    isEditable: .constant(true),
                    action: {}
                )
            }
        }
        .frame(height: 164)
        .padding(.horizontal, 24)
    }
}

extension LifePhotoButton {
    
    private struct FCPhotoIcon: View {
        var body: some View {
            FCIcon.pictureMedium
                .resizable()
                .renderingMode(.template)
                .frame(width: 42, height: 42)
                .foregroundColor(Color.white)
        }
    }

    private struct FCAddPhotoIcon: View {
        var body: some View {
            FCIcon.addPictureMedium
                .resizable()
                .renderingMode(.template)
                .frame(width: 42, height: 42)
                .foregroundColor(Color.white)
        }
    }
    
}
