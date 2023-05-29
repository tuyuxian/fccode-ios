//
//  MessageCellModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import Foundation

struct MessageCell: Hashable, Codable, Equatable, Identifiable {
    var id = UUID()
    var message: String
    var timestamp: String
    var isReceived: Bool
    var isRead: Bool
}
