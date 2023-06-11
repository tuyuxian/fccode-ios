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
    @Published var selectedSheet: SheetView?

    @Published var user: User
    
    /// Toast message
    @Published var bannerMessage: String?
    @Published var bannerType: Banner.BannerType?
    
    /// Alert
    @Published var appAlert: AppAlert?
    
    init(user: User) {
        print("-> [Basic Info] vm init")
        self.user = user
    }

    deinit {
        print("-> [Basic Info] vm deinit")
    }
}

extension BasicInfoViewModel {
    // MARK: helper functions
    public func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = ISO8601DateFormatter().date(from: self.user.dateOfBirth) {
            return dateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
    public func getNationalitiesString() -> String {
        return String(
            self.user.citizen.reduce("") { result, nationality in
                return result + nationality.name + ", "
            }.dropLast(2)
        )
    }
    
    public func getEthnicitiesString() -> String {
        return String(
            self.user.ethnicity.reduce("") { result, ethnicity in
                return result + ethnicity.type.getString() + ", "
            }.dropLast(2)
        )
    }
    
    public func extractFileName(
        url: String
    ) -> String? {
        if let url = URL(string: url) {
            return url.lastPathComponent
        }
        return nil
    }
}

extension BasicInfoViewModel {
    
    public func voiceDeleteOnTap() {
        self.appAlert = .basic(
            title: "Do you really want to delete it?",
            message: "",
            actionLabel: "Yes",
            cancelLabel: "No",
            action: self.deleteVoiceMessage
        )
    }

    public func deleteVoiceMessage() {
        self.state = .loading
        guard let fileName = self.extractFileName(
            url: self.user.voiceContentURL ?? ""
        ) else {
            showError()
            return
        }
        Task {
            do {
                let url = try await GraphAPI.getPresignedDeleteUrl(fileName: fileName)
                guard let url = url else {
                    showError()
                    return
                }
                let success = try await AWSS3().deleteObject(presignedURL: url)
                guard success else {
                    showError()
                    return
                }
                let statusCode = try await GraphAPI.updateUser(
                    userId: self.user.id,
                    input: GraphQLAPI.UpdateUserInput(
                        voiceContentURL: nil
                    )
                )
                guard statusCode == 200 else {
                    showError()
                    return
                }
                self.state = .complete
            } catch {
                showError()
                print(error.localizedDescription)
            }
        }
    }
    
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
    
    public func editableRowOnTap(view: AnyView) {
        self.selectedSheet = SheetView(
            sheetContent: view
        )
    }
        
    private func showError() {
        DispatchQueue.main.async {
            self.state = .error
            self.bannerMessage = "Something went wrong"
            self.bannerType = .error
        }
    }
}
