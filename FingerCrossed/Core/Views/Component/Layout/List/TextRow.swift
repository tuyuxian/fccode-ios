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
    @Binding var isEditing: Bool
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            isEditing
            ? VStack {
                Button {
                    isSelected.toggle()
                } label: {
                    Image(
                        isSelected
                        ? "CheckBoxSelected"
                        : "CheckBox")
                        .resizable()
                        .frame(
                            width: 24,
                            height: 24
                        )
                }
            }
            .frame(
                width: 50,
                height: 50
            )
            : nil
            
            !isEditing
            ? Avatar(
                avatarUrl: avatarUrl,
                size: 50,
                isActive: isActive
            )
            : nil
            
            VStack(
                alignment: .leading,
                spacing: 2
            ) {
                HStack(
                    alignment: .top,
                    spacing: 0
                ) {
                    Text(username)
                        .fontTemplate(.pSemibold)
                        .foregroundColor(Color.text)
                        .lineLimit(1)
                    Spacer()
                    Text(timestamp)
                        .fontTemplate(.captionRegular)
                        .foregroundColor(Color.text)
                    
                }
                .frame(height: 24)
                
                HStack(spacing: 0) {
                    Text(latestMessage)
                        .fontTemplate(
                            unreadMessageCount > 0
                            ? .pSemibold
                            : .pRegular
                        )
                        .foregroundColor(Color.textHelper)
                        .lineLimit(1)
                    Spacer()
                    unreadMessageCount > 0
                    ? UnreadHint(count: $unreadMessageCount)
                    : nil
                }
                .frame(height: 24)
            }
        }
        .padding(
            EdgeInsets(
                top: 16,
                leading: 24,
                bottom: 16,
                trailing: 24
            )
        )
    }
}

struct TextItem_Previews: PreviewProvider {
    static var previews: some View {
        TextRow(
            username: .constant("Kelly"),
            avatarUrl: .constant("https://i.pravatar.cc/150?img=5"),
            latestMessage: .constant("This is a test message from Sam."),
            timestamp: .constant("05:17 pm"),
            unreadMessageCount: .constant(9),
            isActive: .constant(true),
            isEditing: .constant(false)
        )
    }
}

private struct UnreadHint: View {
    
    @Binding var count: Int
    
    var body: some View {
        if count > 99 {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gold)
                .frame(
                    width: 26,
                    height: 18,
                    alignment: .center
                )
                .overlay(
                    Text("99+")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                )
                .padding(.bottom, 2)
                
        } else if count > 9 {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gold)
                .frame(
                    width: 22,
                    height: 18,
                    alignment: .center
                )
                .overlay(
                    Text("\(count)")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                )
                .padding(.bottom, 2)
        } else {
            Circle()
                .fill(Color.gold)
                .frame(
                    width: 18,
                    height: 18,
                    alignment: .center
                )
                .overlay(
                    Text("\(count)")
                        .fontTemplate(.captionMedium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)
                )
                .padding(.bottom, 2)
        }
    }
}
