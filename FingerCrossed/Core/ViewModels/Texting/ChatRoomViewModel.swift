//
//  ChatRoomViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/24/23.
//

import SwiftUI

class ChatRoomViewModel: ObservableObject {
    
    @AppStorage("UserId") var userId: String = ""

    /// View state
    @Published var state: ViewStatus = .none
    @Published var isKeyboardShowUp: Bool = false
    @Published var showEditSheet: Bool = false
    @Published var showCamera: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var showUnmatchDialog: Bool = false
    @Published var isUnmatched: Bool = false
    @Published var isBot: Bool = false
    
    /// Alert
    @Published var fcAlert: FCAlert?
    @Published var showCameraAlert: Bool = false
    @Published var showPhotoLibraryAlert: Bool = false
    
    /// Permission manager
    let photoLibraryPermissionManager = PhotoLibraryPermissionManager()
    let cameraPermissionManager = CameraPermissionManager()
    
    @Published var selectedImage: UIImage?
    @Published var imageUrl: URL?
    
    @Published var messageCellList: [MessageCell] = [
        MessageCell(
            message: "https://i.pravatar.cc/150?img=5",
            timestamp: "10:40",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "https://d2yydc9fog8bo7.cloudfront.net/image/9b08e0b9-fcee-434c-8447-6f061d35ebb0.jpg",
            timestamp: "13:40",
            isReceived: false,
            isRead: false
        ),
        MessageCell(
            message: "https://d2yydc9fog8bo7.cloudfront.net/image/679484ad-201b-4722-8bb8-85cd65fd0a33.jpg",
            timestamp: "19:40",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "Why keep sending me the same message?",
            timestamp: "14:20",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "Cuz I'm bot.",
            timestamp: "14:20",
            isReceived: false,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "中文測試.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "That's great to hear! 🎉 What are you up to today?.",
            timestamp: "13:45",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: " I'm doing well too, thanks for asking!",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I'm good, thanks! 🙌 How about you? 💁‍♂️",
            timestamp: "15:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "Hey, how are you? 🤔",
            timestamp: "14:50",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "This is the first test message.",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "Why keep sending me the same message?",
            timestamp: "14:20",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "Cuz I'm bot.",
            timestamp: "14:20",
            isReceived: false,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "中文測試.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "That's great to hear! 🎉 What are you up to today?.",
            timestamp: "13:45",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: " I'm doing well too, thanks for asking!",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I'm good, thanks! 🙌 How about you? 💁‍♂️",
            timestamp: "15:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "Hey, how are you? 🤔",
            timestamp: "14:50",
            isReceived: true,
            isRead: false
        ),
        MessageCell(
            message: "I got your message.",
            timestamp: "14:20",
            isReceived: false,
            isRead: true
        ),
        MessageCell(
            message: "This is the first test message.",
            timestamp: "13:45",
            isReceived: true,
            isRead: false
        )
    ]

}

extension ChatRoomViewModel {
    public func cameraPermissionAlert() {
        self.fcAlert = .action(
            type: .action,
            title: self.cameraPermissionManager.alertTitle,
            message: self.cameraPermissionManager.alertMessage,
            primaryLabel: "Setting",
            primaryLabelColor: Color.systemBlue, 
            primaryAction: {
                UIApplication.shared.open(
                    URL(string: UIApplication.openSettingsURLString)!
                )
            },
            secondaryLabel: "Cancel",
            secondaryAction: { self.fcAlert = nil })
    }
    
    @MainActor
    public func cameraOnTap() {
        switch cameraPermissionManager.permissionStatus {
        case .notDetermined:
            cameraPermissionManager.requestPermission { granted, _ in
                guard granted else { return }
                self.showCamera = true
            }
        case .denied:
            self.cameraPermissionAlert()
        default:
            self.showCamera = true
        }
    }
    
    @MainActor
    private func upload(
        data: Data?
    ) async throws {
        let url = try await MediaService.getPresignedPutUrl(.case(.image))
        guard let url = url else { throw FCError.LifePhoto.getPresignedUrlFailed }
        let remoteUrl = try await AWSS3.uploadImage(
            data,
            toPresignedURL: URL(string: url)!
        )
        imageUrl = remoteUrl
    }
    
    func uploadImage() {
        Task {
            do {
                try await upload(
                    data: selectedImage?.jpegData(compressionQuality: 0.1)
                )
                if let url = imageUrl {
                    messageCellList.append(
                        MessageCell(
                            message: url.absoluteString,
                            timestamp: "",
                            isReceived: false,
                            isRead: true)
                    )
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
