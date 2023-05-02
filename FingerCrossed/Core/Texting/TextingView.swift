//
//  TextingView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 3/31/23.
//

import SwiftUI

struct TextingView: View {
    
    @State var isEditing = false
    
    @State private var textData: [Message] = [
        Message (username: "中文測試", avatarUrl: "https://i.pravatar.cc/150?img=3", latestMessage: "這是一個中文訊息測試", timestamp: "05:17 pm", unreadMessageCount: 0, isActive: true),
        Message (username: "Chris", avatarUrl: "https://i.pravatar.cc/150?img=4", latestMessage: "這是一個很長的中文訊息123123123測試", timestamp: "05:17 pm", unreadMessageCount: 1, isActive: true),
        Message (username: "Kelly", avatarUrl: "https://i.pravatar.cc/150?img=5", latestMessage: "This is a test message from Sam.", timestamp: "05:17 pm", unreadMessageCount: 5, isActive: true),
        Message (username: "Soorya Kiran Parimala Jeyagopal", avatarUrl: "https://i.pravatar.cc/150?img=59", latestMessage: "This is a long test message from Sam.", timestamp: "05:17 pm", unreadMessageCount: 2, isActive: false),
        Message (username: "Alex", avatarUrl: "https://i.pravatar.cc/150?img=7", latestMessage: "This is a test message from Sam.", timestamp: "05:17 pm", unreadMessageCount: 0, isActive: false),
        Message (username: "Anderson", avatarUrl: "https://i.pravatar.cc/150?img=8", latestMessage: "This is a long test message from Sam.", timestamp: "05:17 pm", unreadMessageCount: 1, isActive: false),
        Message (username: "Savvina", avatarUrl: "https://i.pravatar.cc/150?img=9", latestMessage: "This is a long test message from Sam.", timestamp: "Yesterday", unreadMessageCount: 0, isActive: false),
        Message (username: "Jenny", avatarUrl: "https://i.pravatar.cc/150?img=10", latestMessage: "This is a long test message from Sam.", timestamp: "Wednesday", unreadMessageCount: 0, isActive: false),
        // for unread > 100
        Message (username: "Lawrence", avatarUrl: "https://scontent-dfw5-2.xx.fbcdn.net/v/t1.6435-1/49325793_1547271238709034_7588984728431099904_n.jpg?stp=dst-jpg_p100x100&_nc_cat=108&ccb=1-7&_nc_sid=7206a8&_nc_ohc=GaxQykPv5YcAX9z-0ua&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent-dfw5-2.xx&oh=00_AfDrGLcrPSNRmWAZcrOhi6TblR8WgbjNzJH04skcfayAyw&oe=644F530D", latestMessage: "This is a test message from Sam.", timestamp: "03/30/2023", unreadMessageCount: 101, isActive: true)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                TextList(messageList: $textData, isEditing: $isEditing)
            }
            .background(Color.white)
            .cornerRadius(30, corners: [.topLeft, .topRight])
        }
        .navigationBarItems(leading:
            HStack(alignment: .center, spacing: 8) {
                Image("HeaderLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:50, height: 50)

                VStack {
                    Text("Message")
                         .fontTemplate(.h1Medium)
                         .foregroundColor(Color.text)
                         .frame(height: 44)
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 24)
            )
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
        }
    }
}
