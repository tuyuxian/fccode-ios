//
//  VoiceMessageActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageActionSheet: View {
    
    @ObservedObject var vm: BasicInfoViewModel
    
    @State private var showEditSheet: Bool = false

    var body: some View {
        Sheet(
            size: [.height(138)],
            hasHeader: false,
            hasFooter: false,
            header: {},
            content: {
                VStack(
                    alignment: .leading,
                    spacing: 30
                ) {
                    Button {
                        vm.voiceDeleteOnTap()
                    } label: {
                        HStack(spacing: 20) {
                            Image("Trash")
                                .resizable()
                                .frame(width: 24, height: 24)

                            Text("Delete")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    
                    Button {
                        showEditSheet.toggle()
                    } label: {
                        HStack(spacing: 20) {
                            Image("Edit")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Edit Voice Message")
                                .fontTemplate(.h3Medium)
                                .foregroundColor(Color.text)
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showEditSheet) {
                        VoiceMessageEditSheet()
                    }
                }
                .padding(.top, 15) // 30 - 15
                .appAlert($vm.appAlert)
            },
            footer: {}
        )
    }
}

struct VoiceMessageActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageActionSheet(
            vm: BasicInfoViewModel(user: User.MockUser)
        )
    }
}
