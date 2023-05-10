//
//  TextList.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct TextList: View {
    
    @Binding var messageList: [Message]
    
    @Binding var isEditing: Bool
        
    var body: some View {
        List {
            ForEach(
                Array($messageList.enumerated()),
                id: \.element.id
            ) { index, message in
                VStack(spacing: 0) {
                    // Top padding
                    index == 0
                    ? HStack {}
                        .frame(height: 14)
                    : nil
                    
                    ZStack {
                        TextRow(
                            username: message.username,
                            avatarUrl: message.avatarUrl,
                            latestMessage: message.latestMessage,
                            timestamp: message.timestamp,
                            unreadMessageCount: message.unreadMessageCount,
                            isActive: message.isActive,
                            isEditing: $isEditing
                        )
                        
                        if !isEditing {
                            NavigationLink(
                                destination: ChatRoomView(
                                    username: message.username,
                                    avatarUrl: message.avatarUrl,
                                    isActive: message.isActive
                                )
                                .navigationBarBackButtonHidden(true)
                                .toolbarRole(.editor)
                            ) {
                                EmptyView()
                            }
                            .listRowBackground(Color.white)
                            .buttonStyle(PlainButtonStyle())
                            .opacity(0)
                        }
                    }
                    
                    index != $messageList.count - 1
                    ? Divider()
                        .foregroundColor(Color.surface3)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 24,
                                bottom: 0,
                                trailing: 24
                            )
                        )
                    : nil
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
            )
            .background(Color.white)
        }
        .scrollIndicators(.hidden)
        .padding(
            EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )
        .listStyle(PlainListStyle())
    }
    
    static private var demoData: Binding<[Message]> {
        Binding.constant(
            [
                Message(
                    username: "中文測試",
                    avatarUrl: "https://i.pravatar.cc/150?img=3",
                    latestMessage: "這是一個中文訊息測試",
                    timestamp: "05:17 pm",
                    unreadMessageCount: 0,
                    isActive: true
                ),
                Message(
                    username: "Kelly",
                    avatarUrl: "https://i.pravatar.cc/150?img=5",
                    latestMessage: "This is a test message from Sam.",
                    timestamp: "05:17 pm",
                    unreadMessageCount: 5,
                    isActive: false
                )
            ]
        )
    }
    
    struct TextList_Previews: PreviewProvider {
        static var previews: some View {
            TextList(
                messageList: demoData,
                isEditing: .constant(false)
            )
        }
    }
}