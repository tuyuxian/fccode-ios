//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {
    /// Observed user view model
    @ObservedObject private var user: UserViewModel
    /// Init basic info view model
    @StateObject var vm = BasicInfoViewModel()
        
    init(user: UserViewModel) {
        self.user = user
    }
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Basic Info",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            ZStack {
                VStack(spacing: 0) {
                    Tab(isSelected: $vm.selectedTab).zIndex(1)
                    if let userData = user.data {
                        Box {
                            TabView(selection: $vm.selectedTab) {
                                BasicInfoContent(
                                    user: user,
                                    vm: vm,
                                    basicInfoOptions: [
                                        DestinationView(
                                            label: "Voice Message",
                                            icon: .edit,
                                            previewText:
                                                userData.voiceContentURL == ""
                                            ? "Add a voice message to your profile"
                                            : "Tap to edit your voice message",
                                            subview: .basicInfoVoiceMessage
                                        ),
                                        DestinationView(
                                            label: "Self Introduction",
                                            icon: .edit,
                                            previewText: {
                                                if let selfIntro = userData.selfIntro {
                                                    if selfIntro != "" {
                                                        return selfIntro
                                                    }
                                                }
                                                return "Tell people more about you!"
                                            }(),
                                            subview: .basicInfoSelfIntro
                                        ),
                                        DestinationView(
                                            label: "Name",
                                            icon: .infoCircle,
                                            previewText: userData.username,
                                            hasSubview: false
                                        ),
                                        DestinationView(
                                            label: "Birthday",
                                            icon: .infoCircle,
                                            previewText: userData.getBirthdayString(),
                                            hasSubview: false
                                        ),
                                        DestinationView(
                                            label: "Gender",
                                            icon: .infoCircle,
                                            previewText: userData.gender.getString(),
                                            hasSubview: false
                                        ),
                                        DestinationView(
                                            label: "Nationality",
                                            icon: .infoCircle,
                                            previewText: Nationality.getNationalitiesString(
                                                from: userData.citizen
                                            ),
                                            hasSubview: false
                                        ),
                                        DestinationView(
                                            label: "Ethnicity",
                                            icon: .infoCircle,
                                            previewText: Ethnicity.getEthnicitiesString(
                                                from: userData.ethnicity
                                            ),
                                            hasSubview: false
                                        )
                                    ]
                                )
                                .tag(TabState.edit)
                                
                                CandidateDetailView(
                                    candidate: userData.getCandidate(),
                                    showIndicator: false
                                )
                                .padding(.top, 54) // 30 + 24 (offset)
                                .tag(TabState.preview)
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                        }
                        .padding(.top, -24) // offset 24px to hidden in tab
                    }
                }
            }
        }
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(
            user: UserViewModel(preview: true)
        )
        .environmentObject(BannerManager())
    }
}

extension BasicInfoView {
    
    struct BasicInfoContent: View {
        /// Banner
        @EnvironmentObject var bm: BannerManager
        /// Observed user view model
        @ObservedObject var user: UserViewModel
        /// Observed basic info view model
        @ObservedObject var vm: BasicInfoViewModel
        
        var basicInfoOptions: [DestinationView<BasicInfoDestination>]
                    
        var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {
                        HStack(spacing: 0) {
                            Text("Life Photos")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                                .frame(height: 24)
                            Spacer()
                        }
                        LifePhotoStack(
                            basicInfoVM: vm,
                            user: user
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    
                    ForEach(
                        Array(basicInfoOptions.enumerated()),
                        id: \.element.id
                    ) { _, destinationView in
                        VStack(spacing: 0) {
                            Divider()
                                .overlay(Color.surface3)
                                .padding(.horizontal, 24)
                            
                            HStack(spacing: 0) {
                                Button {
                                    destinationView.hasSubview
                                    ? vm.editableRowOnTap(destinationView.subview!)
                                    : vm.uneditableRowOnTap()
                                } label: {
                                    FCRow(
                                        label: destinationView.label,
                                        icon: destinationView.icon
                                    ) {
                                        PreviewText(text: destinationView.previewText)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 38) // 54 - 16 (Life Photo Stack)
            .sheet(item: $vm.selectedSheet) { val in
                switch val.sheetContent {
                case .basicInfoVoiceMessage:
                    if let url = user.data?.voiceContentURL {
                        if url != "" {
                            VoiceMessageActionSheet(
                                user: user,
                                selectedSheet: $vm.selectedSheet
                            )
                        } else {
                            VoiceMessageEditSheet(
                                user: user,
                                selectedSheet: $vm.selectedSheet
                            )
                        }
                    }
                case .basicInfoSelfIntro:
                    SelfIntroEditSheet(
                        user: user,
                        text: user.data?.selfIntro ?? ""
                    )
                }
            }
            .showAlert($vm.fcAlert)
            .onChange(of: vm.state) { state in
                if state == .error {
                    bm.pop(
                        title: vm.bannerMessage,
                        type: vm.bannerType
                    )
                    vm.state = .none
                }
            }
        }
    }
}

extension BasicInfoView {
    
    enum TabState: Int {
        case edit
        case preview
    }
    
    struct Tab: View {

        @Binding var isSelected: TabState

        var body: some View {
            HStack(
                alignment: .center,
                spacing: 0
            ) {
                Button {
                    isSelected = .edit
                } label: {
                    Text("Edit")
                }
                .frame(width: (UIScreen.main.bounds.size.width - 48)/2, height: 48)
                .background(isSelected == .edit ? Color.yellow100 : Color.yellow20)
                .cornerRadius(50)
                
                Button {
                    isSelected = .preview
                } label: {
                    Text("Preview")
                }
                .frame(width: (UIScreen.main.bounds.size.width - 48)/2, height: 48)
                .background(isSelected == .preview ? Color.yellow100 : Color.yellow20)
                .cornerRadius(50)
            }
            .frame(width: UIScreen.main.bounds.size.width - 48, height: 48)
            .fontTemplate(.h3Medium)
            .foregroundColor(Color.text)
            .background(Color.yellow20)
            .cornerRadius(50)
        }
    }

}
