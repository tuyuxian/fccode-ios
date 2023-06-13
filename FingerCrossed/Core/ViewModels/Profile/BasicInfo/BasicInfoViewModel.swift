//
//  BasicInfoViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import SwiftUI
import GraphQLAPI

class BasicInfoViewModel: ObservableObject {
    
    /// View state
    @Published var state: ViewStatus = .none
    @Published var selectedTab: BasicInfoTabState = .edit
    @Published var selectedSheet: SheetView<BasicInfoDestination>?

    @Published var user: User
    
    /// Toast message
    @Published var bannerMessage: String?
    @Published var bannerType: Banner.BannerType?
    
    /// Alert
    @Published var appAlert: AppAlert?
    
    ///
    @Published var basicInfoOptions: [DestinationView<BasicInfoDestination>]
    
    init(user: User) {
        print("-> [Basic Info] vm init")
        self.user = user
        self.basicInfoOptions = [
            DestinationView(
                label: "Voice Message",
                icon: .edit,
                previewText:
                    user.voiceContentURL == ""
                    ? "Add a voice message to your profile"
                    : "",
                subview: .basicInfoVoiceMessage
            ),
            DestinationView(
                label: "Self Introduction",
                icon: .edit,
                previewText: {
                    if let selfIntro = user.selfIntro {
                        if selfIntro != "" {
                            return selfIntro
                        }
                    }
                    return "Tell people more about you!"
                }(),
                subview: .basicInfoSelfIntro
            ),
            DestinationView(
                label: "Name",
                icon: .infoCircle,
                previewText: user.username,
                hasSubview: false
            ),
            DestinationView(
                label: "Birthday",
                icon: .infoCircle,
                previewText: user.getBirthdayString(),
                hasSubview: false
            ),
            DestinationView(
                label: "Gender",
                icon: .infoCircle,
                previewText: user.gender.getString(),
                hasSubview: false
            ),
            DestinationView(
                label: "Nationality",
                icon: .infoCircle,
                previewText: Nationality.getNationalitiesString(from: user.citizen),
                hasSubview: false
            ),
            DestinationView(
                label: "Ethnicity",
                icon: .infoCircle,
                previewText: Ethnicity.getEthnicitiesString(from: user.ethnicity),
                hasSubview: false
            )
        ]
    }

    deinit {
        print("-> [Basic Info] vm deinit")
    }
}

// MARK: helper functions
extension BasicInfoViewModel {
    
    private func extractFileName(
        url: String
    ) -> String? {
        if let url = URL(string: url) {
            return url.lastPathComponent
        }
        return nil
    }
}

extension BasicInfoViewModel {
    @MainActor
    public func voiceDeleteOnTap() {
        self.appAlert = .basic(
            title: "Do you really want to delete it?",
            message: "",
            actionLabel: "Yes",
            cancelLabel: "No",
            action: self.deleteVoiceMessage
        )
    }
    
    @MainActor
    private func deleteVoiceMessage() {
        Task {
            do {
                self.state = .loading
                guard let fileName = self.extractFileName(url: self.user.voiceContentURL ?? "") else {
                    throw FCError.VoiceMessage.unknown
                }
                let url = try await MediaService.getPresignedDeleteUrl(fileName: fileName)
                guard let url = url else { throw FCError.VoiceMessage.getPresignedUrlFailed }
                let success = try await AWSS3.deleteObject(presignedURL: url)
                guard success else { throw FCError.VoiceMessage.deleteS3ObjectFailed }
                let statusCode = try await UserService.updateUser(
                    userId: self.user.id,
                    input: GraphQLAPI.UpdateUserInput(
                        voiceContentURL: ""
                    )
                )
                guard statusCode == 200 else { throw FCError.VoiceMessage.updateUserFailed }
                self.state = .complete
            } catch {
                self.showError()
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    public func uneditableRowOnTap() {
        self.appAlert = .basic(
            title: "Do you really want to change it?",
            // swiftlint: disable line_length
            message: "To provide a better overall experience, users are only allowed to change this information once.",
            // swiftlint: enable line_length
            actionLabel: "Yes",
            cancelLabel: "No",
            action: {
                // TODO(Sam): send email
                self.bannerMessage = "We've sent a reset link to your email!"
                self.bannerType = .info
                self.state = .error
            }
        )
    }
    
    @MainActor
    public func editableRowOnTap(_ sheetContent: BasicInfoDestination) {
        self.selectedSheet = SheetView(
            sheetContent: sheetContent
        )
    }
    
    private func showError() {
        self.state = .error
        self.bannerMessage = "Something went wrong"
        self.bannerType = .error
    }
}
