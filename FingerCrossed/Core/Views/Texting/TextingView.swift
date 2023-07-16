//
//  TextingView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 3/31/23.
//

import SwiftUI

struct TextingView: View {
    
    @StateObject var vm = TextingViewModel()
    @EnvironmentObject var vmTab: TabBar.ViewModel
    
    var body: some View {
        ContainerWithLogoHeaderView(headerTitle: "Chats") {
            VStack(spacing: 0) {
                Box {
                    TextList(
                        messageList: $vm.textData,
                        vm: vm,
                        showTab: $vmTab.showTab
                    )
                }
            }
            .showAlert($vm.fcAlert)
        }
    }
}

struct TextingView_Previews: PreviewProvider {
    static var previews: some View {
        TextingView()
            .environmentObject(TabBar.ViewModel())
    }
}
