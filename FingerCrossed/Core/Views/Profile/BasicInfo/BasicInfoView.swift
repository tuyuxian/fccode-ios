//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Reference basic info view model
    @StateObject var vm: BasicInfoViewModel
    
    var body: some View {
        ContainerWithHeaderView(
            parentTitle: "Profile",
            childTitle: "Basic Info",
            showSaveButton: .constant(false),
            isLoading: .constant(false)
        ) {
            ZStack {
                VStack(spacing: 0) {
                    BoxTab(isSelected: $vm.selectedTab)
                        .zIndex(1)
                    
                    Box {
                        switch vm.selectedTab {
                        case .edit:
                            BasicInfoContent(
                                vm: vm,
                                basicInfoOptions: [
                                    ChildView(
                                         label: "Voice Message",
                                         icon: "Edit",
                                         subview: {
                                             vm.user.voiceContentURL == ""
                                             ? AnyView(VoiceMessageEditSheet(
                                                hasVoiceMessage:
                                                    vm.user.voiceContentURL != nil &&
                                                    vm.user.voiceContentURL != "",
                                                sourceUrl: vm.user.voiceContentURL
                                             ))
                                             : AnyView(VoiceMessageActionSheet(vm: vm))
                                         }(),
                                         preview:
                                            vm.user.voiceContentURL == ""
                                            ? AnyView(PreviewText(
                                                text: "Add a voice message to your profile"
                                            ))
                                            : AnyView(EmptyView()),
                                         hasSubview: true
                                    ),
                                    ChildView(
                                        label: "Self Introduction",
                                        icon: "Edit",
                                        subview: AnyView(
                                            SelfIntroEditSheet(
                                                vm: vm,
                                                text: vm.user.selfIntro ?? ""
                                            )
                                        ),
                                        preview: AnyView(
                                            PreviewText(
                                                text: {
                                                    if let selfIntro = vm.user.selfIntro {
                                                        if selfIntro != "" {
                                                            return selfIntro
                                                        }
                                                    }
                                                    return "Tell people more about you!"
                                                }()
                                            )
                                        ),
                                        hasSubview: true
                                    ),
                                    ChildView(
                                        label: "Name",
                                        icon: "InfoCircle",
                                        preview: AnyView(PreviewText(text: vm.user.username)),
                                        hasSubview: false
                                    ),
                                    ChildView(
                                        label: "Birthday",
                                        icon: "InfoCircle",
                                        preview: AnyView(PreviewText(text: vm.getDateString())),
                                        hasSubview: false
                                    ),
                                    ChildView(
                                        label: "Gender",
                                        icon: "InfoCircle",
                                        preview: AnyView(PreviewText(text: vm.user.gender.getString())),
                                        hasSubview: false
                                    ),
                                    ChildView(
                                        label: "Nationality",
                                        icon: "InfoCircle",
                                        preview: AnyView(PreviewText(text: vm.getNationalitiesString())),
                                        hasSubview: false
                                    ),
                                    ChildView(
                                        label: "Ethnicity",
                                        icon: "InfoCircle",
                                        preview: AnyView(PreviewText(text: vm.getEthnicitiesString())),
                                        hasSubview: false
                                    )
                                 ]
                            )
                        case .preview:
                            EmptyView()
                        }
                    }
                    .padding(.top, -24) // offset 24px to hidden in tab
                }
            }
            .appAlert($vm.appAlert)
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

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(
            vm: BasicInfoViewModel(user: User.MockUser)
        )
        .environmentObject(BannerManager())
    }
}

private struct BasicInfoContent: View {
    
    @ObservedObject var vm: BasicInfoViewModel
    
    @State var basicInfoOptions: [ChildView]
        
    var body: some View {
        ScrollView {
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
//                        LifePhotoStack(vm: ProfileViewModel())
//                            .frame(height: (proxy.size.width - 62)/2)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                
                ForEach(
                    Array(basicInfoOptions.enumerated()),
                    id: \.element.id
                ) { _, childView in
                    VStack(spacing: 0) {
                        Divider()
                            .overlay(Color.surface3)
                            .padding(.horizontal, 24)

                        HStack(spacing: 0) {
                            Button {
                                childView.hasSubview
                                ? vm.editableRowOnTap(view: childView.subview)
                                : vm.uneditableRowOnTap()
                            } label: {
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
        .scrollIndicators(.hidden)
        .padding(.top, 38) // 54 - 16 (Life Photo Stack)
        .sheet(item: $vm.selectedSheet) { val in
            val.sheetContent
        }
    }
}

struct SheetView: Identifiable {
    let id = UUID()
    let sheetContent: AnyView
}
