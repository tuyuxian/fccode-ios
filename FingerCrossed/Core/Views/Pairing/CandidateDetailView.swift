//
//  CandidateDetailView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/17/23.
//

import SwiftUI

struct CandidateDetailView: View {
    @State var candidateModel: CandidateModel
    @State var lifePhotoList: [LifePhoto]
    @State var isPlay: Bool = false
    @State var config = LifePhotoViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4.0) {
                    Text(candidateModel.username)
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 2)
                    
                    HStack {
                        CandidateDetailItem(iconName: "GenderNeutralWhite", label: candidateModel.gender)
                            
                        CandidateDetailItem(iconName: "AgeWhite", label: String(candidateModel.age))
                    }
                    .padding(.horizontal, 24)
                    
                    HStack {
                        CandidateDetailItem(iconName: "LocationWhite", label: candidateModel.location)
                        
                        CandidateDetailItem(iconName: "GlobeWhite", label: candidateModel.nationality)
                    }
                    .padding(.horizontal, 24)
                    
                }
                .padding(.top, 30)
                
                Text(candidateModel.selfIntro)
                    .fontTemplate(.pRegular)
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                
                VStack(spacing: 20) {
                    Text("Voice Message")
                        .fontTemplate(.h3Medium)
                        .foregroundColor(Color.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        Button {
                            withAnimation {
                                isPlay.toggle()
                            }
                        } label: {
                            Image(isPlay ? "pause" : "play")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.white)
                                .background(
                                    Circle()
                                        .foregroundColor(Color.yellow100)
                                        .frame(width: 50, height: 50)
                                )
                        }
                        LottieView(lottieFile: "soundwave.json")
                            .frame(width: 230, height: 50)
                    }
                }
                .padding(.horizontal, 24)
                
                Divider()
                    .padding(.horizontal, 24)
                
                ForEach(lifePhotoList) { list in
                    VStack(spacing: 10.5) {
                        AsyncImage(
                            url: URL(string: list.photoUrl),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                EmptyView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaleEffect(config.imageScale)
                                    .offset(config.imageOffset)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(16)
                                    .padding(.horizontal, 24)

                            case .failure:
                                Shimmer()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(list.caption)
                            .foregroundColor(Color.text)
                            .fontTemplate(.pRegular)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
            }
        }
    }
}

struct CandidateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateDetailView(
            candidateModel:
                CandidateModel(
                    lifePhotoList: [LifePhoto](),
                    username: "UserName",
                    // swiftlint: disable line_length
                    selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!",
                    // swiftlint: enable line_length
                    gender: "Female",
                    age: 30,
                    location: "Tempe",
                    nationality: "America"
                ),
            lifePhotoList: [
                LifePhoto(
                    // swiftlint: disable line_length
                    photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c",
                    caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor",
                    // swiftlint: enable line_length
                    position: 0,
                    scale: 1,
                    offset: CGSize.zero
                ),
                LifePhoto(
                    // swiftlint: disable line_length
                    photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg",
                    caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor",
                    // swiftlint: enable line_length
                    position: 1,
                    scale: 1,
                    offset: CGSize.zero
                )
            ]
        )
    }
}
