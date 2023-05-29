//
//  UserStateViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/18/23.
//

import Foundation
import SwiftUI

class UserStateViewModel: ObservableObject {
        
    enum ViewState: Int {
        case landing
        case onboarding
        case main
    }
    
    @AppStorage("isLogin") var isLogin: Bool = false
    
    @AppStorage("token") var token: String?
    
    @Published var user: User?
    
    @Published var viewState: ViewState = .landing
    
}
