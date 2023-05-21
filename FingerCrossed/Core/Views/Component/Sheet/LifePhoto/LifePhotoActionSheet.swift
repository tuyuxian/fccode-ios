//
//  LifePhotoActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/20/23.
//

import SwiftUI

struct LifePhotoActionSheet: View {
    
    @State var showEditModal: Bool = false
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(
                alignment: .leading,
                spacing: 30
            ) {
                Button {
                    // TODO(Sam): add delete method
                } label: {
                    HStack(spacing: 20) {
                        Image(vm.hasLifePhoto ? "Trash" : "CameraBased")
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text(vm.hasLifePhoto ? "Delete" : "Take Photos")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                        Spacer()
                    }
                }

                Button {
                    showEditModal = true
                } label: {
                    HStack(spacing: 20) {
                        Image(vm.hasLifePhoto ? "Edit" : "PictureBased")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(vm.hasLifePhoto ? "Edit Photos" : "Upload Photos")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                        Spacer()
                    }
                }
                .sheet(isPresented: $showEditModal) {
                    LifePhotoEditSheet(
                        vm: vm,
                        text: vm.selectedLifePhoto?.caption ?? ""
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
            .background(Color.white)
            .presentationDetents([.height(138)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct LifePhotoActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoActionSheet(
            vm: ProfileViewModel()
        )
    }
}
