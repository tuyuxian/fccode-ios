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
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                VStack (spacing: 4.0){
                    Text(candidateModel.username)
                        .font(.h2Medium)
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
                
                Divider()
                    .padding(.horizontal, 24)
                
                Text(candidateModel.selfIntro)
                    .font(.pRegular)
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                
                ForEach(lifePhotoList) { list in
                    VStack (spacing: 10.5){
                        AsyncImage(
                            url: URL(string: list.photoUrl),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                EmptyView() // TODO(Sam): Replace with shimmer later
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal, 24)

                            case .failure:
                                ProgressView() // TODO(Sam): Replace with shimmer later
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(list.caption)
                            .foregroundColor(Color.text)
                            .font(.pRegular)
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
        CandidateDetailView(candidateModel: CandidateModel(LifePhotoList: [LifePhoto](), username: "UserName", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Female", age: 30, location: "Tempe", nationality: "America"), lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor", position: 0), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor", position: 1)])
    }
}
