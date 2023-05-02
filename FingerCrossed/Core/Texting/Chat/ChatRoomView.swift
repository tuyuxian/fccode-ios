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
    
    @State var isBot: Bool = false
    
    // This data will be fetch here in the future version
    // Message should be soreted by timestamp in descending order
    @State var messageCellList: [MessageCell] = [
        MessageCell(
            message: "Why keep sending me the same message?",
            timestamp: "14:20",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "Cuz I'm bot.",
            timestamp: "14:20",
            isReceived: false,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "中文測試.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "That's great to hear! 🎉 What are you up to today?.",
            timestamp: "13:45",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: " I'm doing well too, thanks for asking!",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I'm good, thanks! 🙌 How about you? 💁‍♂️",
            timestamp: "15:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "Hey, how are you? 🤔",
            timestamp: "14:50",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "This is the first test message.",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        ),
    ]
    @EnvironmentObject private var vm: TabViewModel
    
    var body: some View {
        Box {
            ChatView(
                avatarUrl: $avatarUrl,
                messageCellList: $messageCellList
            )
            
            self.isBot
            ? BotBanner()
            : nil
            
            self.isBot
            ? nil
            : MessageInputField()
        }
        .onTapGesture {
            withAnimation(
                .easeInOut(
                    duration: 0.16
                )
            ) {
                UIApplication.shared.closeKeyboard()
            }
        }
        .navigationBarItems(
            leading:
                HStack(
                    alignment: .center,
                    spacing: 8
                ) {
                    NavigationBarBackButton()
                        .frame(width: 24, height: 24)
                        // leading padding for navigation bar is 16px
                        // offset 3px already
                        .padding(.leading, 5)
                    
                    Avatar(
                        avatarUrl: avatarUrl,
                        size: 33.33,
                        isActive: isActive,
                        dotBackground: Color.background
                    )
                        // offset 5px back
                        .padding(.leading, -5)
                    
                    Text(username)
                        .fontTemplate(.h1Medium)
                        .foregroundColor(Color.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                .frame(height: 40)
                // top navbar height is 44px in default
                // navbar title with subtile is 40px
                // to achieve 75px from top => 75 + 40 - 59(safe area) - 44 = 12
                // offset 1px to avoid online status being overlapped
                .padding(.top, 11)
        )
        .padding(.top, 19)
        .background(Color.background)
        .onAppear(perform: {
            vm.showTab = false
        })
        .onDisappear(perform: {
            withAnimation(.easeInOut(duration: 0.1)) {
                vm.showTab = true
            }
        })
    }
}

//struct ChatRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatRoomView(
//            username: .constant("Kelly"),
//            avatarUrl: .constant("https://i.pravatar.cc/150?img=5"),
//            isActive: .constant(true)
//        )
//    }
//}

private struct BotBanner: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to message center! \n We will sent you latest news here.")
                .fontTemplate(.pRegular)
                .foregroundColor(Color.text)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 255, height: 50)

            
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(
            EdgeInsets(
                top: 7,
                leading: 24,
                bottom: 0,
                trailing: 24
            )
        )
        .background(Color.background)
    }
}
