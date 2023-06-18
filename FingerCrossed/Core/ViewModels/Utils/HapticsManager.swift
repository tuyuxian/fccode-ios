//
//  HapticsManager.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/12/23.
//

import Foundation
import SwiftUI

class HapticsManager: ObservableObject {
    
    @Published var impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        
    init() {
        impactFeedback.prepare()
    }
}
