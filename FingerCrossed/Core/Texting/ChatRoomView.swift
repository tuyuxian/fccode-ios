//
//  ChatRoomView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct ChatRoomView: View {
    
    @Binding var username: String
    @Binding var avatarUrl: String
    @Binding var isActive: Bool
    
    // This data will be fetch here in the future version
    // Message should be soreted by timestamp in descending order
    @State var messageCellList: [MessageCell] = [
        MessageCell(message: "Why keep sending me the same message?", timestamp: "14:20", isReceived: true, isRead: false),
        MessageCell(message: "Cuz I'm bot.", timestamp: "14:20", isReceived: false, isRead: false),
        MessageCell(message: "I got your message.", timestamp: "14:20", isReceived: false, isRead: true),
        MessageCell(message: "I got your message.", timestamp: "14:20", isReceived: false, isRead: true),
        MessageCell(message: "中文測試.", timestamp: "14:20", isReceived: false, isRead: true),
        MessageCell(message: "That's great to hear! 🎉 What are you up to today?.", timestamp: "13:45", isReceived: false, isRead: true),
        MessageCell(message: " I'm doing well too, thanks for asking!", timestamp: "13:45", isReceived: true, isRead: false),
        MessageCell(message: "I'm good, thanks! 🙌 How about you? 💁‍♂️", timestamp: "15:20", isReceived: false, isRead: true),
        MessageCell(message: "Hey, how are you? 🤔", timestamp: "14:50", isReceived: true, isRead: false),
        MessageCell(message: "I got your message.", timestamp: "14:20", isReceived: false, isRead: true),
        MessageCell(message: "This is the first test message.", timestamp: "13:45", isReceived: true, isRead: false),
    ]
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                // message bubble area
                ChatView(
                    avatarUrl: $avatarUrl,
                    messageCellList: $messageCellList
                )
                
                // message input
                MessageInputField()

            }
            .background(Color.white)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
            
        }
        .navigationBarItems(leading:
            HStack(alignment: .center, spacing: 13.88) {
                    Avatar(
                        avatarUrl: avatarUrl,
                        size: 34,
                        isActive: isActive,
                        dotBackground: Color.background
                    )
                    Text(username)
                        .fontTemplate(.h1Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 40)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
            }
            .padding(.top, 10)
        )
        .padding(.top, 19)
        .background(Color.background)
    }
    
    static private var demoUsername: Binding<String> {
        Binding.constant("Kelly")
    }
    
    static private var demoAvatarUrl: Binding<String> {
        Binding.constant("https://i.pravatar.cc/150?img=5")
    }
    
    static private var demoIsActive: Binding<Bool> {
        Binding.constant(true)
    }
    
    static private var demoUnreadMessageCount: Binding<Int> {
        Binding.constant(1)
    }
    
    struct ChatRoomView_Previews: PreviewProvider {
        static var previews: some View {
            ChatRoomView(
                username: demoUsername,
                avatarUrl: demoAvatarUrl,
                isActive: demoIsActive
            )
        }
    }
}
