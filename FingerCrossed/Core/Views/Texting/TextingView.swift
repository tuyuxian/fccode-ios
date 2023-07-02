//
//  TextingView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 3/31/23.
//

import SwiftUI

struct TextingView: View {
    
    @StateObject var vm = TextingViewModel()
    
    var body: some View {
        ContainerWithLogoHeaderView(headerTitle: "Chats") {
            VStack(spacing: 0) {
                Box {
                    TextList(
                        messageList: $vm.textData,
                        vm: vm
                    )
                }
            }
            .showAlert($vm.fcAlert)
//            .navigationBarItems(
//                trailing:
//                    HStack(alignment: .center) {
//                        HeaderButton(
//                            name: .constant(vm.getIconButtonName(state: vm.iconButtonStatus)),
//                            isLoading: .constant(false),
//                            action: vm.getIconButtonAction(state: vm.iconButtonStatus)
//                        )
//                    }
//                    .frame(height: 40)
//                    .padding(
//                        EdgeInsets(
//                            top: 0,
//                            leading: 0,
//                            bottom: 0,
//                            trailing: 8 // Navigation bar has 16px padding at trailing
//                        )
//                    )
//            )
//            .alert(isPresented: $vm.showAlert) {
//                Alert(
//                    title: Text("Do you really want to permanently delete these conversation(s)?")
//                        .font(Font.system(size: 18, weight: .medium)),
//                    primaryButton: .destructive(
//                        Text("Delete")
//                    ) {
//                        // TODO(Sam): add error banner if failed
//                    },
//                    secondaryButton: .cancel(
//                        Text("Cancel")
//                    )
//                )
//            }
        }
    }
}

struct TextingView_Previews: PreviewProvider {
    static var previews: some View {
        TextingView()
    }
}
