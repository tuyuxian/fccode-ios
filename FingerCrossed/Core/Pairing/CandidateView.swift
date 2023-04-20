//
//  CandidateView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import SwiftUI

struct CandidateView: View {
    @State var candidateModel: CandidateModel
    @State var lifePhotoList: [LifePhoto]
    @State var index = 0
    @State private var currentTab = 0
    @State var isSheetPresented: Bool = false
    @State var isLiked: Bool = false
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                TabView (selection: $currentTab) {
                    ForEach(lifePhotoList) { list in

                        AsyncImageLoader(
                            url: URL(string: list.photoUrl)!,
                            placeholder: {
                                Text("Loading...")
                            },
                            image: { Image(uiImage: $0)})
                        .tag(lifePhotoList.firstIndex(where: { $0 == list })!)
                        
                    }
                }
                .frame(width: geometry.size.width)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
                .onChange(of: currentTab) { value in
                    index = value
                }
                .onTapGesture (count: 2) {
                    isLiked.toggle()
                }
            }
            

            
            VStack (spacing: 0.0) {
                Spacer()
                    .frame(height: 70)
                //carousel index section
                HStack (spacing: 14){
                    ForEach(0..<lifePhotoList.count, id: \.self) { index in
                        
                        if index == self.index {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white)
                                .frame(width: 40, height: 8)
                        }else {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                
                Spacer()
                
                
                //Heart Button Section
                VStack (spacing: 12){
                    
                    Button {
                        print("like")
                        isLiked.toggle()
                    } label: {
                        Image("HeartWhite")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(isLiked ? Color.warning : Color.white)
                    }
                    .buttonStyle(IconButtonWithBackground(size: 38, buttonColor: Color.text.opacity(0.4)))
                    
                    Button {
                        print("dislike")
                    } label: {
                        Image("BrokenHeartWhite")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.white)
                    }
                    .buttonStyle(IconButtonWithBackground(size: 38, buttonColor: Color.text.opacity(0.4)))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
                
                //CandidateInfo Section
                ZStack {
                    VStack (spacing: 8.0){
                        Text(candidateModel.username)
                            .fontTemplate(.h2Medium)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 10)
                        
                        HStack {
                            CandidateDetailItem(iconName: "GenderNeutralWhite", label: candidateModel.gender, iconColor: Color.white, labelColor: Color.white)
                                
                            CandidateDetailItem(iconName: "AgeWhite", label: String(candidateModel.age), iconColor: Color.white, labelColor: Color.white)
                        }
                        .padding(.horizontal, 19)
                        
                        HStack {
                            CandidateDetailItem(iconName: "LocationWhite", label: candidateModel.location, iconColor: Color.white, labelColor: Color.white)
                            
                            CandidateDetailItem(iconName: "GlobeWhite", label: candidateModel.nationality, iconColor: Color.white, labelColor: Color.white)
                        }
                        .padding(.horizontal, 19)
                        .padding(.bottom, 12)
                        
                    }
                    .onTapGesture {
                        print("\(isSheetPresented)")
                        isSheetPresented.toggle()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.text.opacity(0.4))
                    )
                    .padding(.horizontal, 24)
                    
                    Button {
                        print("link to candidate detail view")
                        print("Btb: \(isSheetPresented)")
                        isSheetPresented.toggle()
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
                .padding(.bottom, 30)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .sheet(isPresented: $isSheetPresented) {
            print("Sheet dismissed")
        } content: {
            CandidateDetailView(candidateModel: candidateModel, lifePhotoList: lifePhotoList)
                .presentationDetents([.large])
        }
        
        
    }
    
    func imageIsLandscape(url: String) -> Bool {
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                
                return pixelWidth >= pixelHeight ? true : false
                //return "Width: \(pixelWidth), Height: \(pixelHeight)"
            }
        }
        return false
    }
    
}

struct CandidateView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateView(candidateModel: CandidateModel(LifePhotoList: [LifePhoto](), username: "UserName", selfIntro: "selfIntro", gender: "Female", age: 30, location: "Tempe", nationality: "America"), lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "caption2", position: 1)])
    }
}
