//
//  CandidateView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/12/23.
//

import SwiftUI

struct CandidateView: View {
    
    @State var candidate: CandidateModel
    
    @State private var photoIndex = 0
    
    @State private var currentTab = 0
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                TabView(selection: $currentTab) {
                    ForEach(candidate.lifePhotos) { lifePhoto in
                        FCAsyncImage(
                            url: URL(string: lifePhoto.contentUrl)!
                        )
                        .frame(width: geometry.size.width)
                        .clipped()
                        .tag(lifePhoto.position)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentTab) { val in
                    withAnimation(.spring()) {
                        photoIndex = val
                    }
                }
                .onTapGesture(count: 2) {
                    
                }
            }
            
            VStack(spacing: 0) {
                if candidate.lifePhotos.count > 1 {
                    HStack(spacing: 14) {
                        ForEach(
                            0..<candidate.lifePhotos.count,
                            id: \.self
                        ) { index in
                            if index == photoIndex {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                                    .frame(width: 40, height: 8)
                            } else {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                    .padding(.top, 60)
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color.text.opacity(0.4))
                        .frame(width: 50, height: 50)
                        .overlay(
                            FCIcon.heartMedium
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.white)
                                .frame(width: 36, height: 36)
                        )
                    
                    Circle()
                        .fill(Color.text.opacity(0.4))
                        .frame(width: 50, height: 50)
                        .overlay(
                            FCIcon.brokenHeartMedium
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.white)
                                .frame(width: 36, height: 36)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 16)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.text.opacity(0.4))
                    .frame(height: 112)
                    .overlay(
                        ZStack(alignment: .top) {
                            VStack(spacing: 6) {
                                Text(candidate.username)
                                    .fontTemplate(.h2Medium)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CandidateDetailView.InfoCard(
                                    candidate: candidate,
                                    labelColor: Color.white
                                )
                            }
                            
                            FCIcon.moreWhite
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(10)
                    )
                    .onTapGesture { showSheet.toggle() }
                    .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .frame(width: UIScreen.main.bounds.width)
        }
        .sheet(isPresented: $showSheet) {
            CandidateDetailView(candidate: candidate)
                .presentationDetents([.large])
                .preferredColorScheme(.light)
        }
        .overlay(
            ZStack {
                Color.text.opacity(0.4)
                
                LottieView(
                    lottieFile: "heart.json",
                    loop: false
                )
                .frame(width: 200, height: 200)
//                isLiked ?
//                Image("HeartPink")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 90, height: 90)
//                : nil
//
//                isDisliked ?
//                Image("BrokenHeartPink")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 90, height: 90)
//                : nil

            }
            .ignoresSafeArea(.all)
//            .opacity(isLiked || isDisliked ? 1 : 0)
        )
    }
    
}

struct CandidateView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateView(
            candidate: CandidateModel.MockCandidate
        )
    }
}
