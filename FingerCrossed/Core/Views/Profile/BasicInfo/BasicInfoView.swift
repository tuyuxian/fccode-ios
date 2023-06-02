//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    @State private var selectedTab: BasicInfoTabState = .edit
    
    var body: some View {
        ZStack {
            ContainerWithHeaderView(
                parentTitle: "Profile",
                childTitle: "Basic Info",
                showSaveButton: .constant(false),
                isLoading: .constant(false)
            ) {
                VStack(spacing: 0) {
                    BoxTab(isSelected: $selectedTab)
                        .zIndex(1)
                    Box {
                        switch selectedTab {
                        case .edit:
                            BasicInfoContent(
                                vm: vm,
                                basicInfoOptions: [
                                    ChildView(
                                         label: "Voice Message",
                                         icon: "Edit",
                                         subview: AnyView(
                                            VoiceMessageActionSheet()
                                         ),
                                         preview:
                                            vm.user.voiceContentURL == ""
                                            // swiftlint: disable line_length
                                            ? AnyView(PreviewText(text: "Add a voice message to your profile"))
                                            // swiftlint: enable line_length
                                            : AnyView(EmptyView()),
                                         hasSubview: true
                                    ),
                                    ChildView(
                                        label: "Self Introduction",
                                        icon: "Edit",
                                        subview: AnyView(SelfIntroEditSheet(text: vm.user.selfIntro!)),
                                        preview: AnyView(PreviewText(text: vm.user.selfIntro!)),
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
                                        preview: AnyView(
                                            PreviewText(
                                                text: vm.getDateString()
                                            )
                                        ),
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
                                        preview: AnyView(
                                            PreviewText(
                                                text: String(
                                                    vm.user.citizen.reduce("") { result, nationality in
                                                        return result + nationality.name + ", "
                                                    }.dropLast(2)
                                                )
                                            )
                                        ),
                                        hasSubview: false
                                    ),
                                    ChildView(
                                        label: "Ethnicity",
                                        icon: "InfoCircle",
                                        preview: AnyView(
                                            PreviewText(
                                                text: String(
                                                    vm.user.ethnicity.reduce("") { result, ethnicity in
                                                        return result + ethnicity.type.getString() + ", "
                                                    }.dropLast(2)
                                                )
                                            )
                                        ),
                                        hasSubview: false
                                    )
                                 ]
                            )
                        case .preview:
                            CandidateDetailView(
                                candidateModel: CandidateModel(
                                    lifePhotoList: [LifePhoto](),
                                    username: "UserName",
                                    selfIntro: "Hi there! I'm a 25-year-old woman",
                                    gender: "Female",
                                    age: 30,
                                    location: "Tempe",
                                    nationality: "America"
                                ),
                                lifePhotoList: [
                                    LifePhoto(
                                        contentUrl: "https://i.pravatar.cc/150?img=6",
                                        caption: "malesuada",
                                        position: 0,
                                        scale: 1,
                                        offset: CGSize.zero
                                    ),
                                    LifePhoto(
                                        contentUrl: "https://i.pravatar.cc/150?img=7",
                                        caption: "malesuada fames ac",
                                        position: 1,
                                        scale: 1,
                                        offset: CGSize.zero
                                    )
                                ]
                            )
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
        BasicInfoView(
            vm: ProfileViewModel()
        )
    }
}

private struct BasicInfoContent: View {

    @ObservedObject var vm: ProfileViewModel
    
    @State var basicInfoOptions: [ChildView]
    
    @State private var selectedSheet: BasicInfoSheetView?
    
    @State private var showAlert: Bool = false
        
    var body: some View {
        GeometryReader { proxy in
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
                        LifePhotoStack(vm: vm)
                            .frame(height: (proxy.size.width - 62)/2)
                    }
                    .padding(
                        EdgeInsets(
                            top: 16,
                            leading: 24,
                            bottom: 16,
                            trailing: 24
                        )
                    )
                    
                    ForEach(
                        Array(basicInfoOptions.enumerated()),
                        id: \.element.id
                    ) { _, childView in
                        VStack(spacing: 0) {
                            Divider().overlay(Color.surface3)
                                .padding(.horizontal, 24)
                            
                            HStack(spacing: 0) {
                                if childView.hasSubview {
                                    EditableRow(
                                        row: {
                                            ListRow(
                                                label: childView.label,
                                                icon: childView.icon
                                            ) {
                                                childView.preview
                                            }
                                        },
                                        selectedSheet: $selectedSheet,
                                        sheetContent: childView.subview
                                    )
                                } else {
                                    UneditableRow(
                                        showAlert: $showAlert
                                    ) {
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
            .padding(.top, 38) // 54 - 16 (Life Photo Stack)
        }
        .sheet(item: $selectedSheet) { val in
            val.sheetContent
        }
    }
}

private struct UneditableRow<Content: View>: View {
    
    @EnvironmentObject var bm: BannerManager
    
    @Binding var showAlert: Bool
        
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
                    bm.banner = .init(
                        title: "We've sent a reset link to your email!",
                        type: .info
                    )
                },
                secondaryButton: .cancel(
                    Text("No")
                )
            )
        }
    }
}

private struct EditableRow<Row: View>: View {
        
    @ViewBuilder var row: Row
    
    @Binding var selectedSheet: BasicInfoSheetView?
    
    @State var sheetContent: AnyView
    
    var body: some View {
        Button {
            selectedSheet = BasicInfoSheetView(sheetContent: sheetContent)
        } label: {
            row
        }
    }
}

private struct BasicInfoSheetView: Identifiable {
    let id = UUID()
    let sheetContent: AnyView
}
