//
//  TextRow.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct TextRow: View {
    @Binding var username: String
    @Binding var avatarUrl: String
    @Binding var latestMessage: String
    @Binding var timestamp: String // The type will change to int after API integration
    @Binding var unreadMessageCount: Int
    @Binding var isActive: Bool
    
    var body: some View {
        HStack {
            // avatar
            Avatar(avatarUrl: avatarUrl, size: 50, isActive: isActive)
                .padding(.horizontal, 13)
            
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        // username
                        Text(username)
                            .fontTemplate(.h3Medium)
                            .foregroundColor(Color.text)
                            .lineLimit(1)
                        Spacer()
                        // timestamp
                        Text(timestamp)
                            .fontTemplate(.captionRegular)
                            .foregroundColor(Color.text)
                        
                    }
                    .padding(.bottom, 2)
                    
                    HStack {
                        // message
                        Text(latestMessage)
                            .fontTemplate(unreadMessageCount > 0 ? .pMedium : .pRegular)
                            .foregroundColor(Color.text)
                            .lineLimit(1)
                        Spacer()
                        // badge for count > 0
                        unreadMessageCount > 0
                        ? UnreadHint(count: $unreadMessageCount)
                        : nil
 
                    }
                    .padding(.top, 2)
                    
                }
                
            }
        }
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
    }
    
    static private var demoUsername: Binding<String> {
        Binding.constant("Kelly")
    }
    static private var demoAvatarUrl: Binding<String> {
        Binding.constant("https://i.pravatar.cc/150?img=5")
    }
    static private var demoLatestMessage: Binding<String> {
        Binding.constant("This is a test message from Sam.")
    }
    static private var demoTimestamp: Binding<String> {
        Binding.constant("05:17 pm")
    }
    static private var demoUnreadMessageCount: Binding<Int> {
        Binding.constant(9)
    }
    static private var demoIsActive: Binding<Bool> {
        Binding.constant(true)
    }
            
    struct TextItem_Previews: PreviewProvider {
        static var previews: some View {
            TextRow(
                username: demoUsername,
                avatarUrl: demoAvatarUrl,
                latestMessage: demoLatestMessage,
                timestamp: demoTimestamp,
                unreadMessageCount: demoUnreadMessageCount,
                isActive: demoIsActive
            )
        }
    }
}

private struct UnreadHint: View {
    @Binding var count: Int
    var body: some View {
        if (count > 99) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gold)
                .frame(width: 26, height: 18, alignment: .center)
                .overlay(
                    Text("99+")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .padding(.bottom, -2)
                )
                .padding(.bottom, 2)
                
        } else if (count > 9) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gold)
                .frame(width: 22, height: 18, alignment: .center)
                .overlay(
                    Text("\(count)")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .padding(.bottom, -2)
                )
                .padding(.bottom, 2)
        } else {
            Circle()
                .fill(Color.gold)
                .frame(width: 18, height: 18, alignment: .center)
                .overlay(
                    Text("\(count)")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                        .padding(.bottom, -2)
                )
                .padding(.bottom, 2)
        }
    }
}
