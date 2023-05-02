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
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            VStack(spacing: 0) {
                ForEach(
                    $messageCellList,
                    id: \.id
                ) { messageCell in
                    MessageBubble(
                        message: messageCell.message,
                        isReceived: messageCell.isReceived,
                        avatarUrl: $avatarUrl
                    )
                    .rotationEffect(Angle(degrees: 180))
                }
                // TODO(Sam): annoucement banner and datestamp will be integrated in message bubble array
                // Rules:
                // - if the date first appears -> generate datestamp
                // - add anouncebanner on top
                DateStamp(datestamp: "Wed, Mar 15, 2023")
                    .rotationEffect(Angle(degrees: 180))
                
                AnnoucementBanner(info: "Finger Crossed !\n Hope he or she will be your prefect match.")
                    .rotationEffect(Angle(degrees: 180))
                
                HStack{}
                    .frame(height: 22)
            }
            .padding(.horizontal, 24)
        }
        .scrollDismissesKeyboard(.immediately)
        .rotationEffect(Angle(degrees: 180))
    }
    
    static private var demoData: Binding<[MessageCell]> {
        Binding.constant(
            [
                MessageCell(
                    message: "This is the first test message.",
                    timestamp: "13:45",
                    isReceived: true,
                    isRead: false
                ),
                MessageCell(
                    message: "I got your message.",
                    timestamp: "14:20",
                    isReceived: false,
                    isRead: true
                ),
            ]
        )
    }
    
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView(
                avatarUrl: .constant("https://i.pravatar.cc/150?img=5"),
                messageCellList: demoData
            )
            
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
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.yellow100)
                .cornerRadius(16)
        }
        .padding(.vertical, 8)
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
        .padding(.vertical, 8)
    }
}

