//
//  CustomAlert.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/19/23.
//

import SwiftUI

struct CustomAlert: View {
    
    let title: String
    let message: String
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            dimView
            
            alertView
        }
        .ignoresSafeArea()
    }
    
    private var alertView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                titleVew
                
                messageView
            }
            .padding(16)
            
            Divider()
                .overlay {
                    Color.surface1
                }
            
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
                primaryButtonView
                
                Divider()
                    .overlay {
                        Color.surface1
                    }
                
                secondaryButtonView
            }
        }
        .frame(maxHeight: 50)
    }
    
    @ViewBuilder
    private var primaryButtonView: some View {
        if let button = primaryButton {
            CustomAlertButton(title: button.title) {
                withAnimation {
                    dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    button.action?()
                }
            }
        }
    }
    
    @ViewBuilder
    private var secondaryButtonView: some View {
        if let button = secondaryButton {
            CustomAlertButton(title: button.title, textColor: Color.warning) {
                withAnimation {
                    dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    button.action?()
                }
            }
        }
    }
    
    @ViewBuilder
    private var dismissButtonView: some View {
        if let button = dismissButton {
            CustomAlertButton(title: button.title) {
                withAnimation {
                    dismiss()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    button.action?()
                }
            }
        }
    }
    
    private var dimView: some View {
        Color.black
            .blur(radius: 4)
            .opacity(0.4)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        
        let dismissButton   = CustomAlertButton(title: "OK")
        let primaryButton   = CustomAlertButton(title: "No")
        let secondaryButton = CustomAlertButton(title: "Yes")

        let title = "This is your life. Do what you want and do it often."
        let message = """
                    If you don't like something, change it.
                    If you don't have enough time, stop watching TV.
                    """

        return VStack {
            CustomAlert(
                title: title,
                message: message,
                dismissButton: dismissButton,
                primaryButton: nil,
                secondaryButton: nil
            )
            
            CustomAlert(
                title: title,
                message: message,
                dismissButton: nil,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        }
    }
}
