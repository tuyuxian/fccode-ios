//
//  UserStateManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/18/23.
//

import Foundation
import SwiftUI

class UserStateManager: ObservableObject {
        
    enum ViewState: Int {
        case landing
        case onboarding
        case main
    }
    
    @AppStorage("IsLogin") var isLogin: Bool = false
    
    @AppStorage("UserToken") var token: String?
    
    @AppStorage("UserId") var userId: String?
        
    @Published var viewState: ViewState = .landing
    
}
