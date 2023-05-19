//
//  PairingView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/16/23.
//

import SwiftUI

struct PairingView: View {
    @State var candidateList: [CandidateModel] =
    [CandidateModel(lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "caption2", position: 1)], username: "UserName1", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Female", age: 30, location: "Tempe", nationality: "America"),CandidateModel(lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/lovely-woman-white-dress_144627-23529.jpg?w=1800&t=st=1681804694~exp=1681805294~hmac=c33ecc06aa1daacd3995cbbadb1ef536b15cb90f1730332fea1f3ab717fbcd0d", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://img.freepik.com/premium-photo/woman-sits-table-with-laptop-front-her-freelance-remote-work_401253-999.jpg?w=740", caption: "caption2", position: 1)], username: "UserName2", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Male", age: 35, location: "Chandler", nationality: "America")]
    @State var currentCandidate = 0
    @State var startPos: CGPoint = .zero
    @State var isSwipping = true
    @State var isLiked = false
    @State var isDisLiked = false
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                TabView(selection: $currentCandidate) {
                    ForEach(candidateList) { list in

                        CandidateView(
                            candidateModel: list,
                            lifePhotoList: list.lifePhotoList,
                            isLiked: $isLiked,
                            isDisliked: $isDisLiked
                        )
                        .rotationEffect(.init(degrees: -90))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(candidateList.firstIndex(where: { $0 == list })!)
                        .onDisappear {
                            isLiked = false
                            isDisLiked = false
                        }
                        
//                            .onAppear {
//                                if currentCandidate < candidateList.firstIndex(where: { $0 == list })! {
//                                    candidateList.remove(at: currentCandidate)
//                                }
//                            }
                    }
                    
                }
                .frame(width: geometry.size.height)
                .rotationEffect(.init(degrees: 90))
//                .offset(x: geometry.size.width)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: geometry.size.width)
//                .gesture(DragGesture()
//                        .onChanged { gesture in
//                            if self.isSwipping {
//                                self.startPos = gesture.location
//                                self.isSwipping.toggle()
//                            }
//                        }
//                        .onEnded { gesture in
//                            let xDist =  abs(gesture.location.x - self.startPos.x)
//                            let yDist =  abs(gesture.location.y - self.startPos.y)
//                            if self.startPos.y <  gesture.location.y && yDist > xDist {
//                                print("Down")
//                            }
//                            else if self.startPos.y >  gesture.location.y && yDist > xDist {
//                                print("Up")
//                            }
//                            else if self.startPos.x > gesture.location.x && yDist < xDist {
//                                print("Left")
//                            }
//                            else if self.startPos.x < gesture.location.x && yDist < xDist {
//                                print("Right")
//                            }
//                            self.isSwipping.toggle()
//                            print("\(isSwipping)")
//                        }
//                     )
                .onTapGesture(count: 2) {
//                    candidateList.remove(at: currentCandidate) // remove former candidate
                    withAnimation {
                        currentCandidate += 1
                    }
                }
                .onChange(of: isLiked, perform: { newValue in
                    print("Like: \(newValue)")
                    isLiked = newValue
                    if newValue {
                        print("\(currentCandidate)")
                        withAnimation {
                            currentCandidate += 1
                        }
                    }
                })
                .onChange(of: isDisLiked, perform: { newValue in
                    print("DisLike: \(newValue)")
                    isDisLiked = newValue
                    if newValue {
                        withAnimation {
                            currentCandidate += 1
                        }
                    }
                })
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct PairingView_Previews: PreviewProvider {
    static var previews: some View {
        PairingView(candidateList: [CandidateModel(lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "caption2", position: 1)], username: "UserName1", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Female", age: 30, location: "Tempe", nationality: "America"),CandidateModel(lifePhotoList: [LifePhoto(photoUrl: "https://lh3.googleusercontent.com/KdMX10-xp3FSYfSjaUuw_t0oS-Pjg5QKQMtq8Ne7naQ2Mh84xWxuXZm2-EnoTRDFxqTkEML5_t6Nh8oFEKEREHNtgmpAdwpulpOGEtGoeacxd2AIH2ESHbWxR1ybmx0Lxr3LtGrsZsyE8hvHNoRuuVwKoAnob45uMd9PUx_nHJqFY0aFrX9stOdmf3tncbjVlio5lextSIy3aLZQia4KLhtG64UWndSUT6d_UoF6yGygAtEU-aACTYG75Lsg7UnWXa17153KJBdSig1MXRlGxkVX67TB8yQlD6CB2JWdoefO0RVas40o0khR4T3Bkx53udBUphTO6xVlOvQ4WweI1dkm1mjrUoQsfeL5TpVj46oRbYMEXwF9STJkcxyi_UpBIOUsfrHsg8CCXuBiwW0KmWZai58enm5dptfwXofTJ-GA3R5uvkmflw4etRb0M3NEGQO5vuIrSdsZchZ1I-gaKG2QxsT5KdRiaIDmAfNNSqx5yeVFCNmtolQ1Vp2stj5NvfS1V_URHtxVo1Zp7Bid9hIP2Zp841ycS-lVSF-0uKGSBaBAmbzGf4OVPcbi7lxG-_-djd6CoDKw_vTwI6U9kzFpwe-hK-agLfJzl7Su97r95jOo7W0ZOx9-H0TRGUgI0pKfX09nRhqEv633myYAUaiZStML6onMAy6X1cHJReMq_vOTGt5YhuoLmYSoDa17SeF95JLuohJivlyoTRFRaiPHErDacx5SjPC4MFeB5ZTV-PYnQ8NenNw41SVtuKvZB3BJV8H8-l770L1ipryotRgrXb3DYuIC2WBEwKim-Y8B4-gnn7FBKAsF-pdIMyx9lW1LBa2aPaQy9Nntf3dvOQC0bicodBp5whaMQe7VuiaWXg0s8tAfXoAH3IP2-ZZyeAgCmjIEk5iQUhHWSKzeEGy3XnEsLXG8h19N5BI_nfHiJTjcc_gRF0t1e7BxC5fk47v98-lzv66df2929XAtQ7hLXYu1rni3uSMOX4l9SkIH3rLqgI8g3JgKYRq8U5SRP_OMCqXHB2d-Z25vWmPsRwQFY1g=w1918-h1438-s-no?authuser=3", caption: "caption1", position: 0), LifePhoto(photoUrl: "https://lh3.googleusercontent.com/XJP_ZZIxasPaf7LyqWl0cWIdsNfeg9mhhJrj_hUOo6s6aXpxrtRvn85rE9m9hEOQSU7x8sOmjiI-gptsTFUMiVYVDbhZph-dajyVSTFFppJD_HBrhrOVw9QTFhm1dHeonHCV-j1mmbM510g8kjf9BM3BO0q8jMv0QWfmabsY0cSqDL3lip68SrSE8zfl_1ihbXmXEn5dQXTp-eOiZfeHwOw-zNKWtrRMA6yhJI4wU3_ax6UXsOznN9JyFgkuPrQvSbNwrQzPL0hD5yEaGYXc4yXPKwzKSbijmkU4GX6y0tSFyb5p7b34kVIdXzlBw0t6YhHqGXTDc5Hd_rLJld-aQeG5ztDh_XCHWQrw9sDrn1u9JRrvc74pSho5GxvZksiDfzM_mtqPZOlPlzMVu9JQuvkoz7UwtsqXPzecd9sTVORhr8pscmtaiFJjY-DeFRcUEXpX5EpOSHlublXLQzgtrR647oLF3nsV4dXHUXwrEDclMzam5-7LPxrLMu1l01PknQN-TRCnvXZIPJZe8fqu5B8lDUXgPwo3wnBaXGnsyljS644o4s3XcxihNRBPyH0uYFXodN_zUCJbK_0l0Zq11UNjriyQbFvM9bC8Lb8p5rlIxcweC0syYKAAE17lRxhx6uYBLGa-A-uAtwU0pFxcDgcKaM5UTnv8Csg0QC89pj7HdOiawj9ySmByutzP_SaTQTmiPKShfSOIaXvtqFVXlQrNBpprMUBF584liRjj3hJtZ0Ec-VT0K7QQ6gmensHa7l2CEz2rzb3oxUSeQ-8WtSavi2kYoD54iyKrbTlRzc3oAUYUn_JKnD55XY_jpLCA90neRVCvDvYoePjHNQ3b61Ll2DPmgBifIbIp71j2xEHmeivmohixZbm9qr-6HMZFl7iuD73npHQGH5iLM5WcNM3q6IUnH_dg3VLc3vN8KzrwJ9ft8Uh3N72MFuR9YavIsOfBUP60JY5ewWt4wfnFXoDtGQmFjnLar5f1VUJLNB9cH4pskCCiYeIRCNrbg00My7B_WoXyOtn3KSUi0xffnD9vgok=w1918-h1438-s-no?authuser=3", caption: "caption2", position: 1)], username: "UserName2", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Male", age: 35, location: "Chandler", nationality: "America")])
    }
}
