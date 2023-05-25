//
//  LifePhotoButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct LifePhotoButton: View {
    
    @ObservedObject var vm: ProfileViewModel
        
    @State var position: Int
    
    @State var halfSize: CGFloat
    
    @State var fullSize: CGFloat
            
    var body: some View {
        Button {
            if position <= vm.currentLifePhotoCount {
                vm.showEditSheet = true
                vm.selectedLifePhoto = vm.user.lifePhoto[position]
                vm.hasLifePhoto = vm.user.lifePhoto[position].photoUrl != ""
            }
        } label: {
            AsyncImage(
                url: URL(string: vm.user.lifePhoto[position].photoUrl),
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
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
                    Image("PictureBased")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 46.15, height: 46.15)
                        .foregroundColor(Color.white)
                @unknown default:
                    Image("PictureBased")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 46.15, height: 46.15)
                        .foregroundColor(Color.white)
                }
            }
        }
        .frame(
            width: position == 0 ? fullSize : halfSize,
            height: position == 0 ? fullSize : halfSize
        )
        .background(
            position <= vm.currentLifePhotoCount
            ? Color.yellow100
            : Color.yellow20
        )
        .cornerRadius(16)
        .contentShape(
            .dragPreview,
            RoundedRectangle(cornerRadius: 16)
        )
    }
}

struct LifePhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoButton(
            vm: ProfileViewModel(),
            position: 0,
            halfSize: 75,
            fullSize: 164
        )
    }
}
