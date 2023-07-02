//
//  FCAlertView.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/19/23.
//

import SwiftUI

struct FCAlertView: View {
    
    let title: String
    let message: String
    let dismissButton: AlertButton?
    let primaryButton: AlertButton?
    let secondaryButton: AlertButton?

    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    
    @Environment(\.dismiss) private var dismiss

        
    var body: some View {
        ZStack {
            dimView
            
            alertView
                .opacity(opacity)
        }
        .ignoresSafeArea(.all)
        .transition(.opacity)
        .task { animate(isShown: true) }
    }
    
    private var alertView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                titleVew
                
                messageView
            }
            .padding(16)
            
            Divider().overlay { Color.surface1 }
            
            buttonView
        }
        .frame(width: 270, alignment: .center)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.white)
        }
    }
    
    @ViewBuilder
    private var titleVew: some View {
        if !title.isEmpty {
            Text(title)
                .fontTemplate(.pSemibold)
                .foregroundColor(Color.text)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    private var messageView: some View {
        if !message.isEmpty {
            Text(message)
                .fontTemplate(.noteMedium)
                .foregroundColor(Color.text)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var buttonView: some View {
        HStack(spacing: 0) {
            if dismissButton != nil {
                dismissButtonView
            } else if primaryButton != nil, secondaryButton != nil {
                secondaryButtonView
                Divider().overlay { Color.surface1 }
                primaryButtonView
            }
        }
        .frame(maxHeight: 50)
    }
    
    @ViewBuilder
    private var primaryButtonView: some View {
        if let button = primaryButton {
            AlertButton(
                title: button.title,
                textColor: Color.warning
            ) {
                button.action?()
                animate(isShown: false) {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    private var secondaryButtonView: some View {
        if let button = secondaryButton {
            AlertButton(title: button.title) {
                button.action?()
                animate(isShown: false) {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    private var dismissButtonView: some View {
        if let button = dismissButton {
            AlertButton(title: button.title) {
                button.action?()
                animate(isShown: false) {
                    dismiss()
                }
            }
        }
    }
    
    private var dimView: some View {
        Color.black
            .background(.ultraThickMaterial)
            .opacity(0.4)
            .opacity(backgroundOpacity)
    }
    
    private func animate(
        isShown: Bool,
        completion: (() -> Void)? = nil
    ) {
        switch isShown {
        case true:
            withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0)) {
                opacity = 1
                backgroundOpacity = 1
            }
    
            completion?()
    
        case false:
            withAnimation(.default) {
                backgroundOpacity = 0
                opacity = 0
            }
    
            completion?()
        }
    }
}

struct FCAlertView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dismissButton   = FCAlertView.AlertButton(title: "OK")
        let primaryButton   = FCAlertView.AlertButton(title: "No")
        let secondaryButton = FCAlertView.AlertButton(title: "Yes")

        let title = "Request unavailable."
        // swiftlint: disable line_length
        let message = "To provide a better overall experience, users are not allowed to change this information."
        // swiftlint: enable line_length

        return VStack {
            FCAlertView(
                title: title,
                message: message,
                dismissButton: dismissButton,
                primaryButton: nil,
                secondaryButton: nil
            )
            
            FCAlertView(
                title: title,
                message: message,
                dismissButton: nil,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        }
    }
}

extension FCAlertView {
    
    struct AlertButton: View {
        @State var title: LocalizedStringKey
        @State var textColor: Color = Color.systemBlue
        @State var action: (() -> Void)?
        
        var body: some View {
            Button {
                action?()
            } label: {
                Text(title)
                    .fontTemplate(.pSemibold)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
        }
    }
    
}
