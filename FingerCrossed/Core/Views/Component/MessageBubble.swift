//
//  MessageBubble.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct MessageBubble: View {
    
    @Binding var message: String
        
    @Binding var isReceived: Bool
        
    @Binding var avatarUrl: String
    
    var body: some View {
        VStack(
            alignment:
                isReceived
                ? .leading
                : .trailing
        ) {
            HStack(
                alignment: .top,
                spacing: 6
            ) {
                isReceived
                ? Avatar(
                    avatarUrl: avatarUrl,
                    size: 34,
                    isActive: false // isActive is false to stick to the design
                )
                : nil
                
                Text(message)
                    .fontTemplate(.pRegular)
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.leading)
                    .padding(
                        EdgeInsets(
                            top: 8,
                            leading: 8,
                            bottom: 8,
                            trailing: 8
                        )
                    )
                    .background(Color.surface3)
                    .cornerRadius(
                        10,
                        corners:
                            isReceived
                            ? [
                                .topRight,
                                .bottomLeft,
                                .bottomRight
                            ]
                            : [
                                .topLeft,
                                .topRight,
                                .bottomLeft
                            ]
                    )
                    .frame(
                        maxWidth: 230,
                        alignment:
                            isReceived
                            ? .leading
                            : .trailing
                    )
            }
            .frame(
                maxWidth: .infinity,
                alignment:
                    isReceived
                    ? .leading
                    : .trailing
            )
            .padding(.vertical, 8)
        }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageBubble(
                message: .constant("This is the first long long and long test message."),
                isReceived: .constant(true),
                avatarUrl: .constant("https://i.pravatar.cc/150?img=5")
            )
            MessageBubble(
                message: .constant("I got your message."),
                isReceived: .constant(false),
                avatarUrl: .constant("")
            )
        }
    }
}
