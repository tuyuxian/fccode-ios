//
//  LifePhotoButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct LifePhotoButton: View {
    @State var content_url: String = ""
    @State var position: Int = 1
    @State var caption: String = ""
    @Binding var showModal: Bool
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        Button {
            showModal = true
        } label: {
            AsyncImage(
                url: URL(string: content_url),
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
                    ProgressView() // TODO(Sam): Replace with shimmer later
                @unknown default:
                    Image("PictureBased")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 46.15, height: 46.15)
                        .foregroundColor(Color.white)
                }
            }
        }
        .frame(width: position == 0 ? 164 : 75, height: position == 0 ? 164 : 75)
        .background(position <= 1 ? Color.yellow100 : Color.yellow20)
        .cornerRadius(16)
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.position = 5
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    self.position = 1
                    self.offset = CGSize.zero
                }
        )
        .sheet(isPresented: $showModal) {
            LifePhotoActionSheet()
        }
    }
}

struct LifePhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoButton(showModal: .constant(false))
    }
}

struct LifePhotoActionSheet: View {
    
    @State var showModal: Bool = false
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                HStack(alignment: .center) {
                    Text("Life Photos")
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                }
                HStack(spacing: 91) {
                    Button {
                        // TODO(Sam): add action for life photo
                    } label: {
                        Image("CameraBased")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 56, height: 56)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.orange100)
                    .cornerRadius(50)
                    
                    Button {
                        showModal = true
                    } label: {
                        Image("PictureBased")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 56, height: 56)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.orange100)
                    .cornerRadius(50)
                    .sheet(isPresented: $showModal) {
                        LifePhotoEditSheet()
                    }
                }
            }
            .background(Color.white)
            .presentationDetents([.fraction(0.25)])
        }
    }
}
