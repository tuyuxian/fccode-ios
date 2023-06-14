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
    case singleButton(
        title: String,
        message: String,
        cancelLabel: String
    )
    
    var title: String {
        switch self {
        case .basic(let title, _, _, _, _, _): return title
        case .errors: return "Oopsie!"
        case .singleButton(let title, _, _): return title
        }
    }
    
    var message: String {
        switch self {
        case .basic(_, let message, _, _, _, _): return message
        case .errors(let message): return message
        case .singleButton(_, let message, _): return message
        }
    }
    
    var actionLabel: String {
        switch self {
        case .basic(_, _, let actionLabel, _, _, _): return actionLabel
        case .errors: return "Cancel"
        case .singleButton: return ""
        }
    }
    
    var cancelLabel: String {
        switch self {
        case .basic(_, _, _, let cancelLabel, _, _): return cancelLabel
        case .errors: return "Cancel"
        case .singleButton(_, _, let cancelLabel): return cancelLabel
        }
    }
    
    var action: () -> Void {
        switch self {
        case .basic(_, _, _, _, let action, _): return action
        case .errors: return {}
        case .singleButton: return {}
        }
    }
    
    var actionButtonDefaultStyle: Bool {
        switch self {
        case .basic(_, _, _, _, _, let isDefaultStyle): return isDefaultStyle
        case .errors: return true
        case .singleButton: return true
        }
    }
}

extension View {
    func singleButtonAlert(_ appAlert: Binding<AppAlert?>) -> some View {
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
                dismissButton: .cancel(
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
