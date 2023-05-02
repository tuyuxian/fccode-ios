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
        ContainerWithLogoHeaderView(headerTitle: "Message") {
            VStack(spacing: 0) {
                Box {
                    TextList(
                        messageList: $vm.textData,
                        isEditing: $vm.isEditing
                    )
                }
            }
            .navigationBarItems(
                trailing:
                    HStack(alignment: .center) {
                        HeaderButton(
                            name: .constant(vm.getIconButtonName(state: vm.iconButtonStatus)),
                            action: vm.getIconButtonAction(state: vm.iconButtonStatus)
                        )
                    }
                    .frame(height: 40)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 8 // Navigation bar has 16px padding at trailing
                        )
                    )
            )
<<<<<<< HEAD
        .navigationBarItems(trailing:
                                HStack(alignment: .bottom) {
            HeaderButton(name: "Edit", action: {
                isEditing.toggle()
            })
            
            .padding(.top, 10)
            .padding(.leading, 24)
        })
        .navigationBarItems(trailing:
            HStack(alignment: .bottom) {
                HeaderButton(name: "Edit", action: {
                    isEditing.toggle()
                })
            }
            .padding(.top, 10)
            .padding(.trailing, 8)
        )
        .padding(.top, 19)
        .background(Color.background)
    }

    
    
    struct TextingView_Previews: PreviewProvider {
        static var previews: some View {
            TextingView()
=======
            .alert(isPresented: $vm.showAlert) {
                Alert(
                    title: Text("Do you really want to permanently delete these conversation(s)?")
                        .font(Font.system(size: 18, weight: .medium)),
                    primaryButton: .destructive(
                        Text("Delete")
                    ) {
                        // TODO(Sam): add error banner if failed
                    },
                    secondaryButton: .cancel(
                        Text("Cancel")
                    )
                )
            }
>>>>>>> release
        }
    }
}

struct TextingView_Previews: PreviewProvider {
    static var previews: some View {
        TextingView()
    }
}
