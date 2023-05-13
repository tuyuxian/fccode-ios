//
//  LifePhotoButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct LifePhotoButton: View {
    @State var lifePhoto: LifePhoto
    @State var halfSize: CGFloat
    @State var fullSize: CGFloat
        
    @ObservedObject var config: LifePhotoViewModel
    
    var body: some View {
        Button {
            if lifePhoto.position <= config.currentLifePhotoCount {
                self.config.showEditSheet = true
                self.config.selectedLifePhoto = lifePhoto
                if lifePhoto.photoUrl == "" {
                    self.config.hasLifePhoto = false
                } else {
                    self.config.hasLifePhoto = true
                }
            }
        } label: {
            AsyncImage(
                url: URL(string: lifePhoto.photoUrl),
                transaction: Transaction(animation: .easeInOut)
            ){ phase in
                switch phase {
                case .empty:
                    Image("PictureBased")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 46.15, height: 46.15)
                        .foregroundColor(Color.white)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    ProgressView() // TODO(Sam): Replace with shimmer 
                @unknown default:
                    Image("PictureBased")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 46.15, height: 46.15)
                        .foregroundColor(Color.white)
                }
            }
        }
        .frame(width: lifePhoto.position == 0 ? fullSize : halfSize, height: lifePhoto.position == 0 ? fullSize : halfSize)
        .background(lifePhoto.position <= config.currentLifePhotoCount ? Color.yellow100 : Color.yellow20)
        .cornerRadius(16)
        .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 16))
    }
}

struct LifePhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoButton(
            lifePhoto: LifePhoto(photoUrl: "https://i.pravatar.cc/150?img=6", caption: "", position: 0),
            halfSize: 75,
            fullSize: 164,
            config: LifePhotoViewModel()
        )
    }
}
