//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {
    /// Reference basic info view model
    @StateObject var vm: BasicInfoViewModel
    
    init(user: User) {
        _vm = StateObject(wrappedValue: BasicInfoViewModel(user: user))
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
                    BoxTab(isSelected: $vm.selectedTab).zIndex(1)
                    
                    Box {
                        // FIXME: add tab back
                        BasicInfoContent(
                            vm: vm,
                            basicInfoOptions: vm.basicInfoOptions
                        )
                    }
                    .padding(.top, -24) // offset 24px to hidden in tab
                }
            }
        }
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(user: User.MockUser)
            .environmentObject(BannerManager())
    }
}

private struct BasicInfoContent: View {
    /// Banner
    @EnvironmentObject var bm: BannerManager
    /// Observed basic info view model
    @ObservedObject var vm: BasicInfoViewModel
    ///
    var basicInfoOptions: [DestinationView<BasicInfoDestination>]
        
    var body: some View {
        List {
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
                Button("test1") {
                    print("test1")
                }
                Button("test2") {
                    print("test2")
                }
                Button("test3") {
                    print("test3")
                }
                Button("test4") {
                    print("test4")
                }
                //                    LifePhotoStack(vm: ProfileViewModel())
            }
            .buttonStyle(.plain)
            //            .padding(.vertical, 16)
                
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
            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .padding(0)
        .listStyle(.plain)
        .padding(.top, 38) // 54 - 16 (Life Photo Stack)
        .sheet(item: $vm.selectedSheet) { val in
            switch val.sheetContent {
            case .basicInfoVoiceMessage:
                if vm.user.voiceContentURL != nil && vm.user.voiceContentURL != "" {
                    VoiceMessageActionSheet(vm: vm)
                } else {
                    VoiceMessageEditSheet(
                        hasVoiceMessage: false,
                        sourceUrl: vm.user.voiceContentURL
                    )
                }
            case .basicInfoSelfIntro:
                SelfIntroEditSheet(vm: vm, text: vm.user.selfIntro ?? "")
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

struct SheetView<T>: Identifiable {
    let id = UUID()
    let sheetContent: T
}
