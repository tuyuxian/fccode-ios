//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {

    @State private var selectedTab: Int = 1
    
    let basicInfoOptions: [ChildView] = [
       ChildView(
            label: "Voice Message",
            icon: "Edit",
            subview: AnyView(VoiceMessageEditSheet()),
            preview: AnyView(PreviewText(text: "Add a voice message to your profile")),
            hasSubview: true
       ),
       ChildView(
           label: "Self Introduction",
           icon: "Edit",
           subview: AnyView(SelfIntroEditSheet()),
           preview: AnyView(PreviewText(text: "Hello! I'm ChatGPT, a language model designed to understand and generate human-like language. I'm here to assist you in any way I can with my vast knowledge and natural language processing abilities.")),
           hasSubview: true
       ),
       ChildView(
           label: "Name",
           icon: "InfoBased",
           preview: AnyView(PreviewText(text: "Marine")),
           hasSubview: false
       ),
       ChildView(
           label: "Birthday",
           icon: "InfoBased",
           preview: AnyView(PreviewText(text: "01/01/2000")),
           hasSubview: false
       ),
       ChildView(
           label: "Gender",
           icon: "InfoBased",
           preview: AnyView(PreviewText(text: "Female")),
           hasSubview: false
       ),
       ChildView(
           label: "Nationality",
           icon: "InfoBased",
           preview: AnyView(PreviewText(text: "Taiwan")),
           hasSubview: false
       ),
       ChildView(
           label: "Ethnicity",
           icon: "InfoBased",
           preview: AnyView(PreviewText(text: "Asian")),
           hasSubview: false
       )
    ]
    
    var body: some View {
        ZStack {
            ContainerWithHeaderView(parentTitle: "Profile", childTitle: "Basic Info") {
                VStack(spacing: 0) {
                    BoxTab(isSelected: $selectedTab)
                        .zIndex(1)
                    Box {
                        if selectedTab == 1 {
                            BasicInfoContent(basicInfoOptions: basicInfoOptions)
                        } else {
                            CandidateDetailView(candidateModel: CandidateModel(lifePhotoList: [LifePhoto](), username: "UserName", selfIntro: "Hi there! I'm a 25-year-old woman, born and raised in [City/State/Country]. I'm currently living in [City/State/Country], and I enjoy [hobbies/interests]. Nice to meet you!", gender: "Female", age: 30, location: "Tempe", nationality: "America"), lifePhotoList: [LifePhoto(photoUrl: "https://img.freepik.com/free-photo/smiling-portrait-business-woman-beautiful_1303-2288.jpg?t=st=1681419194~exp=1681419794~hmac=72eb85b89df744cb0d7276e0a0c76a0f568c9e11d1f6b621303e0c6325a7f35c", caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor", position: 0, scale: 1, offset: CGSize.zero), LifePhoto(photoUrl: "https://lifetouch.ca/wp-content/uploads/2015/03/photography-and-self-esteem.jpg", caption: "malesuada fames ac turpis egestas. Quisque vitae mi sed diam tincidunt euismod. Maecenas sed mollis lorem. Mauris elementum ac tor", position: 1, scale: 1, offset: CGSize.zero)]).padding(38)
                        }
                    }
                    .padding(.top, -24) // offset 24px to hidden in tab
                }
            }
        }
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView()
    }
}

struct BasicInfoContent: View {
    
    @State var basicInfoOptions: [ChildView]
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    @State private var showBanner: Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(
        content: "We've sent a reset link to your email!",
        type: .info
    )
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 0) {
                            Text("Life Photos")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                                .frame(height: 24)
                                .padding(.top, 2)
                                .padding(.bottom, -2)
                            Spacer()
                        }
                        LifePhotoStack()
                            .frame(height: (proxy.size.width - 62)/2)
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                    
                    ForEach(Array(basicInfoOptions.enumerated()), id: \.element.id) { _, childView in
                        VStack(spacing: 0) {
                            Divider().foregroundColor(Color.surface3)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            HStack(spacing: 0) {
                                if childView.hasSubview {
                                    EditableRow(
                                        showSheet: $showSheet,
                                        sheetType: childView.label == "Voice Message" ? 1 : 2
                                    ) {
                                        ListRow(
                                            label: childView.label,
                                            icon: childView.icon
                                        ) {
                                            childView.preview
                                        }
                                    }
                                } else {
                                    UneditableRow(showAlert: $showAlert, showBanner: $showBanner) {
                                        ListRow(
                                            label: childView.label,
                                            icon: childView.icon
                                        ) {
                                            childView.preview
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 38) // 54 - 16 (Life photos)
        }
        .banner(data: $bannerData, show: $showBanner)
    }
}

struct UneditableRow<Content: View>: View {
    
    @Binding var showAlert: Bool
    
    @Binding var showBanner: Bool
    
    @ViewBuilder var row: Content
    
    var body: some View {
        Button {
            showAlert = true
        } label: {
            row
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(
                    "Do you really want to change it?"
                )
                .font(
                    Font.system(
                        size: 18,
                        weight: .medium
                    )
                ),
                message: Text(
                    // swiftlint: disable line_length
                    "To provide a better overall experience, users are only allowed to change this information once."
                    // swiftlint: enable line_length
                ),
                primaryButton: .destructive(
                    Text("Yes")
                ) {
                    showBanner = true
                },
                secondaryButton: .cancel(
                    Text("No")
                )
            )
        }
    }
}

struct EditableRow<Content: View>: View {
    
    @Binding var showSheet: Bool
    // TODO(Sam): refactor in the future
    @State var sheetType: Int
    
    @ViewBuilder var row: Content
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            row
        }
        .sheet(isPresented: $showSheet) {
            if sheetType == 2 {
                SelfIntroEditSheet()
            } else {
                VoiceMessageEditSheet()
            }
        }
    }
}
