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
