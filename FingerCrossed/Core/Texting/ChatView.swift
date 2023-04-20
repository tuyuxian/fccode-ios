//
//  ChatView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct ChatView: View {
    
    @Binding var avatarUrl: String
    @Binding var messageCellList: [MessageCell]
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach($messageCellList, id: \.id) { messageCell in
                MessageBubble(
                    message: messageCell.message,
                    timestamp: messageCell.timestamp,
                    isReceived: messageCell.isReceived,
                    isRead: messageCell.isRead,
                    avatarUrl: $avatarUrl
                )
                .rotationEffect(Angle(degrees: 180))
            }
            // annoucement banner and datestamp will be integration in message bubble array
            DateStamp(datestamp: "Wed, Mar 15, 2023")
                .rotationEffect(Angle(degrees: 180))
            AnnoucementBanner(info: "Finger Crossed !\n Hope he or she will be your prefect match.")
                .rotationEffect(Angle(degrees: 180))
            
        }
        .scrollDismissesKeyboard(.interactively)
        .rotationEffect(Angle(degrees: 180))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    static private var demoAvatarUrl: Binding<String> {
        Binding.constant("https://i.pravatar.cc/150?img=5")
    }
    
    static private var demoData: Binding<[MessageCell]> {
        Binding.constant([
            MessageCell(message: "This is the first test message.", timestamp: "13:45", isReceived: true, isRead: false),
            MessageCell(message: "I got your message.", timestamp: "14:20", isReceived: false, isRead: true),
        ])
    }
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView(avatarUrl: demoAvatarUrl, messageCellList: demoData)
        }
    }
    
}

private struct AnnoucementBanner: View {
    @State var info: String
    var body: some View {
        HStack {
            Text(info)
                .fontTemplate(.captionMedium)
                .foregroundColor(Color.text)
                .multilineTextAlignment(.center)
                .frame(width: 342, height: 44)
                .background(Color.yellow100)
                .cornerRadius(16)
        }
        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
    }
}

private struct DateStamp: View {
    @State var datestamp: String
    var body: some View {
        HStack {
            Text(datestamp)
                .fontTemplate(.captionRegular)
                .foregroundColor(Color.textHelper)
        }
        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
    }
}

