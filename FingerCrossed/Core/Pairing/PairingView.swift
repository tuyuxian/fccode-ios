//
//  ParingView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import SwiftUI

struct ParingView: View {
    @State var candidateModel: CandidateModel
    @State var lifePhoto: LifePhoto
    
    var body: some View {
        VStack (spacing: 0.0) {
            Spacer()
            
            ZStack {
                VStack (spacing: 8.0){
                    Text(candidateModel.username)
                        .font(.h2Medium)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    
                    HStack {
                        CandidateDetailItem(iconName: "GenderNeutralWhite", label: candidateModel.gender)
                            
                        CandidateDetailItem(iconName: "AgeWhite", label: String(candidateModel.age))
                    }
                    .padding(.horizontal, 19)
                    
                    HStack {
                        CandidateDetailItem(iconName: "LocationWhite", label: candidateModel.location)
                        
                        CandidateDetailItem(iconName: "GlobeWhite", label: candidateModel.nationality)
                    }
                    .padding(.horizontal, 19)
                    .padding(.bottom, 12)
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.text.opacity(0.6))
                )
                .padding(.horizontal, 24)
                
                Button {
                    print("link to candidate detail view")
                } label: {
                    Image("MoreWhite")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                        .padding(.top, 15)
                }
                .padding(.horizontal, 24)
                .frame(height: 112, alignment: .top)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
            
            Spacer()
                .frame(height: 30)
            TabBar()
        }
    }
}

struct ParingView_Previews: PreviewProvider {
    static var previews: some View {
        ParingView(candidateModel: CandidateModel(LifePhotoList: [LifePhoto](), username: "UserName", selfIntro: "selfIntro", gender: "Male", age: 30, location: "Tempe", nationality: "America"), lifePhoto: LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "caption", position: 25))
    }
}

struct CandidateDetailItem: View {
    @State var iconName: String = "IconName"
    @State var label: String = "Label"
    
    var body: some View {
        HStack (spacing: 4.0) {
            Image(iconName)
            Text(label)
                .font(.pMedium)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
