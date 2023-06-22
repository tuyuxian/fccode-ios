//
//  PairingViewModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/20/23.
//

import Foundation
import SwiftUI

class PairingViewModel: ObservableObject {
    
    @AppStorage("IsNewUser") var isNewUser: Bool = true
    
    @Published var instructionStep: Int = 1
    
    @Published var state: ViewStatus = .loading
}
