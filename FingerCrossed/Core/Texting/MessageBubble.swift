//
//  MessageBubble.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct MessageBubble: View {
    @Binding var message: String
    @Binding var timestamp: String
    @Binding var isReceived: Bool
    @Binding var isRead: Bool
    @Binding var avatarUrl: String
    
    var body: some View {
        VStack(alignment: isReceived ? .leading : .trailing) {
            HStack(alignment: .top, spacing: 0) {
                // avatar
                isReceived
                ? Avatar(avatarUrl: avatarUrl, size: 34, isActive: false) // set isActive to false due to the design
                    .padding(.trailing, 12)
                : nil
                HStack(alignment: .bottom) {
                    // readstamp and timestamp for sent message
                    isReceived
                    ? nil
                    : VStack {
                        isRead ? ReadStamp() : nil
                        TimeStamp(timestamp: timestamp)
                    }
                    .padding(.leading, 4)
                    
                    // raw text
                    Text(message)
                        .fontTemplate(.pRegular)
                        .foregroundColor(Color.text)
                        .padding(8)
                        .background(Color.background)
                        .cornerRadius(
                            10,
                            corners: isReceived
                            ? [.topRight, .bottomLeft, .bottomRight]
                            : [.topLeft, .topRight, .bottomLeft]
                        )
                        //.frame(maxWidth: 207)
                    
                    // timestamp for received message
                    isReceived
                    ? TimeStamp(timestamp: timestamp)
                        .padding(.trailing, 4)
                    : nil
                }
                .frame(alignment: isReceived ? .leading : .trailing)
            }
            .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
            .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
        }
    }
    
    static private var demoMessage: Binding<String> {
        Binding.constant("Lorem ipsum dolor sit amet, consectetur")
    }
    
    static private var demoTimestamp: Binding<String> {
        Binding.constant("22:22")
    }
    
    static private var demoIsReceived: Binding<Bool> {
        Binding.constant(true)
    }
    
    static private var demoIsRead: Binding<Bool> {
        Binding.constant(false)
    }
    
    static private var demoAvatarUrl: Binding<String> {
        Binding.constant("https://i.pravatar.cc/150?img=5")
    }
    
    struct MessageBubble_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                MessageBubble(
                    message: demoMessage,
                    timestamp: demoTimestamp,
                    isReceived: demoIsReceived,
                    isRead: demoIsRead,
                    avatarUrl: demoAvatarUrl
                )
                MessageBubble(
                    message: demoMessage,
                    timestamp: demoTimestamp,
                    isReceived: Binding.constant(false),
                    isRead: Binding.constant(true),
                    avatarUrl: demoAvatarUrl
                )
            }
        }
    }
}

private struct TimeStamp: View {
    @State var timestamp: String
    var body: some View {
        Text(timestamp)
            .fontTemplate(.captionRegular)
            .foregroundColor(Color.textHelper)
            .multilineTextAlignment(.trailing)
    
    }
}

private struct ReadStamp: View {
    var body: some View {
        Text("Read")
            .fontTemplate(.captionRegular)
            .foregroundColor(Color.textHelper)
            .multilineTextAlignment(.trailing)
    }
}
