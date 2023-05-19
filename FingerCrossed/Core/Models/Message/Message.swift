//
//  Message.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import Foundation

struct Message: Hashable, Codable, Equatable, Identifiable {
    var id = UUID()
    var username: String
    var avatarUrl: String
    var latestMessage: String
    var timestamp: String
    var unreadMessageCount: Int
    var isActive: Bool
}

class TextingViewModel: ObservableObject {
    enum IconButtonStatus {
        case edit, cancel, delete
    }
    
    @Published var isEditing: Bool = false
    
    @Published var iconButtonStatus: IconButtonStatus = .edit
    
    @Published var showAlert: Bool = false
    
    @Published var textData: [Message] = [
        Message(
            username: "中文測試",
            avatarUrl: "https://i.pravatar.cc/150?img=3",
            latestMessage: "這是一個中文訊息測試",
            timestamp: "05:17 pm",
            unreadMessageCount: 0,
            isActive: true
        ),
        Message(
            username: "Chris",
            avatarUrl: "https://i.pravatar.cc/150?img=4",
            latestMessage: "這是一個很長的中文訊息123123123測試",
            timestamp: "05:17 pm",
            unreadMessageCount: 1,
            isActive: true
        ),
        Message(
            username: "Kelly",
            avatarUrl: "https://i.pravatar.cc/150?img=5",
            latestMessage: "This is a test message from Sam.",
            timestamp: "05:17 pm",
            unreadMessageCount: 5,
            isActive: true
        ),
        Message(
            username: "Soorya Kiran Parimala Jeyagopal",
            avatarUrl: "https://i.pravatar.cc/150?img=59",
            latestMessage: "This is a long test message from Sam.",
            timestamp: "05:17 pm",
            unreadMessageCount: 2,
            isActive: false
        ),
        Message(
            username: "Alex",
            avatarUrl: "https://i.pravatar.cc/150?img=7",
            latestMessage: "This is a test message from Sam.",
            timestamp: "05:17 pm",
            unreadMessageCount: 0,
            isActive: false
        ),
        Message(
            username: "Anderson",
            avatarUrl: "https://i.pravatar.cc/150?img=8",
            latestMessage: "This is a long test message from Sam.",
            timestamp: "05:17 pm",
            unreadMessageCount: 1,
            isActive: false
        ),
        Message(
            username: "Savvina",
            avatarUrl: "https://i.pravatar.cc/150?img=9",
            latestMessage: "This is a long test message from Sam.",
            timestamp: "Yesterday",
            unreadMessageCount: 0,
            isActive: false
        ),
        Message(
            username: "Jenny",
            avatarUrl: "https://i.pravatar.cc/150?img=10",
            latestMessage: "This is a long test message from Sam.",
            timestamp: "Wednesday",
            unreadMessageCount: 0,
            isActive: false
        )
    ]
    
    func getIconButtonName(
        state: TextingViewModel.IconButtonStatus
    ) -> String {
        switch state {
        case .edit:
            return "Edit"
        case .cancel:
            return "Cancel"
        case .delete:
            return "Delete"
        }
    }
    
    func getIconButtonAction(
        state: IconButtonStatus
    ) -> () -> Void {
        switch state {
        case .edit:
            return editOnTap
        case .cancel:
            return cancelOnTap
        case .delete:
            return deleteOnTap
        }
    }
    
    func editOnTap() {
        self.isEditing.toggle()
        self.iconButtonStatus = .cancel
    }
    
    func cancelOnTap() {
        self.isEditing.toggle()
        self.iconButtonStatus = .edit
    }
    
    func deleteOnTap() {
        self.isEditing.toggle()
        self.iconButtonStatus = .edit
        self.showAlert = true
        // TODO(Sam): delete messages
    }
}
