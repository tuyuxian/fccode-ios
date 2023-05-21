//
//  LifePhotoActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoActionSheet: View {
    @State var showEditModal: Bool = false
    @ObservedObject var config: LifePhotoViewModel
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    
                } label: {
                    HStack(spacing: 20) {
                        Image(config.hasLifePhoto ? "Trash" : "CameraBased")
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text(config.hasLifePhoto ? "Delete" : "Take Photos")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                Button {
                    showEditModal = true
                } label: {
                    HStack(spacing: 20) {
                        Image("PictureBased")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(config.hasLifePhoto ? "Edit Photos" : "Upload Photos")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                .sheet(isPresented: $showEditModal) {
                    LifePhotoEditSheet(config: config)
                }
            }
            .background(Color.white)
            .presentationDetents([.height(138)])
        }
    }
}

struct LifePhotoActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoActionSheet(config: LifePhotoViewModel())
    }
}
