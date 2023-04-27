//
//  VoiceMessageActionSheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/25/23.
//

import SwiftUI

struct VoiceMessageActionSheet: View {
    @Binding var hasVoiceMessage: Bool
    @State var showEditModal: Bool = false
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                hasVoiceMessage
                ?   Button {
                        
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
                    .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                : nil
                Button {
                    showEditModal = true
                } label: {
                    HStack(spacing: 20) {
                        Image("Mic")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(hasVoiceMessage ? "Record New Message" : "Record Message")
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                .sheet(isPresented: $showEditModal) {
                    VoiceMessageEditSheet()
                }
            }
            .background(Color.white)
            .presentationDetents([.height(138)])
        }
    }
}

struct VoiceMessageActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMessageActionSheet(hasVoiceMessage: .constant(true))
    }
}
