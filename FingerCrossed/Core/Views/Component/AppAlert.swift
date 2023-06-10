//
//  AppAlert.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/7/23.
//

import SwiftUI

enum AppAlert {
    case basic(
        title: String,
        message: String,
        actionLabel: String,
        cancelLabel: String,
        action: () -> Void,
        actionButtonDefaultStyle: Bool = false
    )
    case errors(message: String)
    
    var title: String {
        switch self {
        case .basic(let title, _, _, _, _, _): return title
        case .errors: return "Oopsie!"
        }
    }
    
    var message: String {
        switch self {
        case .basic(_, let message, _, _, _, _): return message
        case .errors(let message): return message
        }
    }
    
    var actionLabel: String {
        switch self {
        case .basic(_, _, let actionLabel, _, _, _): return actionLabel
        case .errors: return "Cancel"
        }
    }
    
    var cancelLabel: String {
        switch self {
        case .basic(_, _, _, let cancelLabel, _, _): return cancelLabel
        case .errors: return "Cancel"
        }
    }
    
    var action: () -> Void {
        switch self {
        case .basic(_, _, _, _, let action, _): return action
        case .errors: return {}
        }
    }
    
    var actionButtonDefaultStyle: Bool {
        switch self {
        case .basic(_, _, _, _, _, let isDefaultStyle): return isDefaultStyle
        case .errors: return true
        }
    }
}

extension View {
    
    func appAlert(_ appAlert: Binding<AppAlert?>) -> some View {
        let alertType = appAlert.wrappedValue
        return alert(
            isPresented: .constant(alertType != nil)
        ) {
            Alert(
                title: Text(alertType?.title ?? "")
                            .foregroundColor(Color.text)
                            .font(
                                Font.system(
                                    size: 18,
                                    weight: .medium
                                )
                            ),
                message: Text(alertType?.message ?? "")
                            .foregroundColor(Color.text)
                            .font(
                                Font.system(
                                    size: 12,
                                    weight: .medium
                                )
                            ),
                primaryButton:
                alertType?.actionButtonDefaultStyle ?? false
                ? .default(
                    Text(alertType?.actionLabel ?? "")
                        .font(
                            Font.system(
                                size: 18,
                                weight: .medium
                            )
                        ),
                    action: {
                        appAlert.wrappedValue = nil
                        alertType?.action() ?? {}()
                    }
                )
                : .destructive(
                    Text(alertType?.actionLabel ?? "")
                        .font(
                            Font.system(
                                size: 18,
                                weight: .medium
                            )
                        ),
                    action: {
                        appAlert.wrappedValue = nil
                        alertType?.action() ?? {}()
                    }
                ),
                secondaryButton: .cancel(
                    Text(alertType?.cancelLabel ?? "")
                        .font(
                            Font.system(
                                size: 18,
                                weight: .medium
                            )
                        ),
                    action: {
                        appAlert.wrappedValue = nil
                    }
                )
            )
        }
    }
    
}
