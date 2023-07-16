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
    
    @StateObject private var vm = ChatRoomViewModel()
    @Binding var showTab: Bool
    
    // This data will be fetch here in the future version
    // Message should be soreted by timestamp in descending order
    
//    @EnvironmentObject private var vm: TabViewModel
    
    var body: some View {
        Box {
            ChatView(
                avatarUrl: $avatarUrl,
                messageCellList: $vm.messageCellList,
                vm: vm
            )
            
            if vm.isBot {
                BotBanner()
            } else if vm.isUnmatched {
                BottomMessage(username: username)
            } else {
                MessageInputField(vm: vm)
            }
        }
        .onDisappear {
            showTab = true
        }
        .onAppear {
            showTab = false
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.16)) {
                UIApplication.shared.closeKeyboard()
            }
        }
        .navigationBarItems(
            leading:
                HStack(
                    alignment: .center,
                    spacing: 8
                ) {
                    NavigationBackButton()
                        .frame(width: 24, height: 24)
                        // leading padding for navigation bar is 16px
                        // offset 3px already
//                        .padding(.leading, 5)
                    
                    Avatar(
                        avatarUrl: avatarUrl,
                        size: 34,
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
                        .frame(width: UIScreen.main.bounds.width - 146, alignment: .leading)
                }
                .frame(height: 40)
                // top navbar height is 44px in default
                // navbar title with subtile is 40px
                // to achieve 75px from top => 75 + 40 - 59(safe area) - 44 = 12
                // offset 1px to avoid online status being overlapped
                .padding(.top, 11), 
            
            trailing:
                HStack(alignment: .center) {
                    IconButton(
                        icon: .more,
                        color: Color.text,
                        action: {
                            withAnimation(.easeInOut) {
                                vm.showUnmatchDialog.toggle()
                            }
                        }
                    )
                    .padding(.trailing, 3.06) // 19.06 - 16(default)
                }
                .frame(height: 40)
                .padding(.top, 11)
        )
        .padding(.top, 16)
        .padding(.bottom, vm.keyboard.currentHeight)
        .background(Color.background)
        .actionSheet(
            isPresented: $vm.showUnmatchDialog,
            description: "",
            actionButtonList: [ActionButton(
                    label: "Unmatch",
                    action: {
                    print("unmatch")
                }
            )]
        )
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView(
            username: .constant("Kelly"),
            avatarUrl: .constant("https://i.pravatar.cc/150?img=5"),
            isActive: .constant(true),
            showTab: .constant(true)
        )
    }
}

private struct BotBanner: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to message center! \n We will sent you latest news here.")
                .fontTemplate(.noteMedium)
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

private struct BottomMessage: View {
    let username: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(
                username.isEmpty
                ? "Oh oh! \n There's no one in this chatroom"
                : "Oh oh! \n\(username) has left the chatroom"
            )
            .fontTemplate(.noteMedium)
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

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        
        (UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets ?? .zero 
        ).insets
        
//        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
