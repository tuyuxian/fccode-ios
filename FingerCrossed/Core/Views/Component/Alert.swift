//
//  Alert.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/24/23.
//

import SwiftUI

public enum FCAlert {
    
    public enum AlertType {
        case action
        case info
        case permission
    }
    
    case action(
        type: AlertType,
        title: String,
        message: String,
        primaryLabel: LocalizedStringKey,
        primaryLabelColor: Color,
        primaryAction: () -> Void,
        secondaryLabel: LocalizedStringKey,
        secondaryAction: () -> Void
    )
    
    case info(
        type: AlertType,
        title: String,
        message: String,
        dismissLabel: LocalizedStringKey,
        dismissAction: () -> Void
    )
    
    var type: AlertType {
        switch self {
        case .action(let type, _, _, _, _, _, _, _): return type
        case .info(let type, _, _, _, _): return type
        }
    }
    
    var title: String {
        switch self {
        case .action(_, let title, _, _, _, _, _, _): return title
        case .info(_, let title, _, _, _): return title
        }
    }
    
    var message: String {
        switch self {
        case .action(_, _, let message, _, _, _, _, _): return message
        case .info(_, _, let message, _, _): return message
        }
    }
    
    var primaryLabel: LocalizedStringKey {
        switch self {
        case .action(_, _, _, let primaryLabel, _, _, _, _): return primaryLabel
        case .info: return ""
        }
    }
    
    var primaryLabelColor: Color {
        switch self {
        case .action(_, _, _, _, let primaryLabelColor, _, _, _): return primaryLabelColor
        case .info: return Color.systemBlue
        }
    }
    
    var primaryAction: () -> Void {
        switch self {
        case .action(_, _, _, _, _, let primaryAction, _, _): return primaryAction
        case .info: return {}
        }
    }
    
    var secondaryLabel: LocalizedStringKey {
        switch self {
        case .action(_, _, _, _, _, _, let secondaryLabel, _): return secondaryLabel
        case .info: return ""
        }
    }
    
    var secondaryAction: () -> Void {
        switch self {
        case .action(_, _, _, _, _, _, _, let secondaryAction): return secondaryAction
        case .info: return {}
        }
    }
    
    var dismissLabel: LocalizedStringKey {
        switch self {
        case .action: return ""
        case .info(_, _, _, let dismissLabel, _): return dismissLabel
        }
    }
    
    var dismissAction: () -> Void {
        switch self {
        case .action: return {}
        case .info(_, _, _, _, let action): return action
        }
    }
    
}

extension View {
    
    func showAlert(_ fcAlert: Binding<FCAlert?>) -> some View {
        let alertType = fcAlert.wrappedValue
        
        if alertType?.type == .action {
            let title   = NSLocalizedString(alertType?.title ?? "", comment: "")
            let message = NSLocalizedString(alertType?.message ?? "", comment: "")

            return modifier(
                AlertModifier(
                    title: title,
                    message: message,
                    primaryButton: FCAlertView.AlertButton(
                        title: alertType?.primaryLabel ?? "",
                        textColor: alertType?.primaryLabelColor ?? Color.warning, 
                        action: alertType?.primaryAction ?? {}
                    ),
                    secondaryButton: FCAlertView.AlertButton(
                        title: alertType?.secondaryLabel ?? "",
                        action: alertType?.secondaryAction ?? {}
                    ),
                    isPresented: .constant(alertType != nil)
                )
            )
        } else {
            let title   = NSLocalizedString(alertType?.title ?? "", comment: "")
            let message = NSLocalizedString(alertType?.message ?? "", comment: "")

            return modifier(
                AlertModifier(
                    title: title,
                    message: message,
                    dismissButton: FCAlertView.AlertButton(
                        title: alertType?.dismissLabel ?? "",
                        action: alertType?.dismissAction ?? {}
                    ),
                    isPresented: .constant(alertType != nil)
                )
            )
        }
    }
    
}
