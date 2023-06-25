//
//  FCAlertModifier.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/19/23.
//

import SwiftUI

struct AlertModifier {
    @Binding private var isPresented: Bool
    
    private let title: String
    private let message: String
    private let dismissButton: FCAlertView.AlertButton?
    private let primaryButton: FCAlertView.AlertButton?
    private let secondaryButton: FCAlertView.AlertButton?
}

extension AlertModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(isPresented: $isPresented) {
                FCAlertView(
                    title: title,
                    message: message,
                    dismissButton: dismissButton,
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            }
    }
}

extension AlertModifier {

    init(
        title: String = "",
        message: String = "",
        dismissButton: FCAlertView.AlertButton,
        isPresented: Binding<Bool>
    ) {
        self.title         = title
        self.message       = message
        self.dismissButton = dismissButton
    
        self.primaryButton   = nil
        self.secondaryButton = nil
    
        _isPresented = isPresented
    }

    init(
        title: String = "",
        message: String = "",
        primaryButton: FCAlertView.AlertButton,
        secondaryButton: FCAlertView.AlertButton,
        isPresented: Binding<Bool>
    ) {
        self.title           = title
        self.message         = message
        self.primaryButton   = primaryButton
        self.secondaryButton = secondaryButton
    
        self.dismissButton = nil
    
        _isPresented = isPresented
    }
    
}
