//
//  BasicInfoViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import Foundation
import SwiftUI
import GraphQLAPI

@MainActor
class BasicInfoViewModel: ObservableObject {
            
    /// View state
    @Published var state: ViewStatus = .none
    @Published var selectedTab: BasicInfoView.TabState = .edit
    @Published var selectedSheet: SheetView<BasicInfoDestination>?
    
    /// Life photo state
    @Published var hasLifePhoto: Bool = false
    @Published var showLifePhotoEditSheet: Bool = false
    @Published var selectedImage: UIImage?
    @Published var selectedLifePhoto: LifePhoto?
    @Published var lifePhotoMap: [Int: LifePhoto] = [Int: LifePhoto]()

    /// Toast message
    @Published var bannerMessage: String?
    @Published var bannerType: Banner.BannerType?
    
    /// Alert
    @Published var fcAlert: FCAlert?

}

extension BasicInfoViewModel {
    
    public func uneditableRowOnTap() {
        self.fcAlert = .info(
            type: .info,
            title: "Request unavailable",
            // swiftlint: disable line_length
            message: "To provide a better overall experience, users are not allowed to change this information.",
            // swiftlint: enable line_length
            dismissLabel: "OK",
            dismissAction: {
                self.fcAlert = nil
            }
        )
    }

    public func editableRowOnTap(_ sheetContent: BasicInfoDestination) {
        self.selectedSheet = SheetView(
            sheetContent: sheetContent
        )
    }

    public func resetImage() {
        self.selectedImage = nil
    }
    
}

extension BasicInfoViewModel {
    
    struct SheetView<T>: Identifiable {
        let id = UUID()
        let sheetContent: T
    }
    
}
