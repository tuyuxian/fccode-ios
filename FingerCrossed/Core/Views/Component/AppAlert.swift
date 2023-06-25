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
        cancelLabel: String,
        action: () -> Void
    )
    case one(
        title: String,
        message: String,
        dismissLabel: LocalizedStringKey,
        dismissAction: () -> Void
    )
    
    var title: String {
        switch self {
        case .basic(let title, _, _, _, _, _): return title
        case .errors: return "Oopsie!"
        case .singleButton(let title, _, _, _): return title
        case .one(let title, _, _, _): return title
        }
    }
    
    var message: String {
        switch self {
        case .basic(_, let message, _, _, _, _): return message
        case .errors(let message): return message
        case .singleButton(_, let message, _, _): return message
        case .one(_, let message, _, _): return message
        }
    }
    
    var actionLabel: String {
        switch self {
        case .basic(_, _, let actionLabel, _, _, _): return actionLabel
        case .errors: return "Cancel"
        case .singleButton: return ""
        case .one: return ""
        }
    }
    
    var cancelLabel: String {
        switch self {
        case .basic(_, _, _, let cancelLabel, _, _): return cancelLabel
        case .errors: return "Cancel"
        case .singleButton(_, _, let cancelLabel, _): return cancelLabel
        case .one: return ""
        }
    }
    
    var action: () -> Void {
        switch self {
        case .basic(_, _, _, _, let action, _): return action
        case .errors: return {}
        case .singleButton(_, _, _, let action): return action
        case .one: return {}
        }
    }
    
    var actionButtonDefaultStyle: Bool {
        switch self {
        case .basic(_, _, _, _, _, let isDefaultStyle): return isDefaultStyle
        case .errors: return true
        case .singleButton: return true
        case .one: return true
        }
    }

    var dismissLabel: LocalizedStringKey {
        switch self {
        case .basic: return ""
        case .errors: return ""
        case .singleButton: return ""
        case .one(_, _, let dismissLabel, _): return dismissLabel
        }
    }
    
    var dismissAction: () -> Void {
        switch self {
        case .basic: return {}
        case .errors: return {}
        case .singleButton: return {}
        case .one(_, _, _, let action): return action
        }
    }
}

extension View {
//    func one(_ appAlert: Binding<AppAlert?>) -> some View {
//        let alertType = appAlert.wrappedValue
//        return alert(
//            title: alertType?.title ?? "",
//            message: alertType?.message ?? "",
//            dismissButton:
//                CustomAlertButton(
//                    title: alertType?.dismissLabel ?? "",
//                    action: alertType?.dismissAction ?? {}
//                ),
//            isPresented: .constant(alertType != nil)
//        )
//    }
    
//    func one(_ appAlert: Binding<AppAlert?>) -> some View {
//        let alertType = appAlert.wrappedValue
//        return
//        alertType != nil
//        ?
//        CustomAlert(
//            title: alertType?.title ?? "",
//            message: alertType?.message ?? "",
//            dismissButton: CustomAlertButton(title: alertType?.dismissLabel ?? "", action: alertType?.dismissAction ?? {}),
//            primaryButton: nil,
//            secondaryButton: nil)
//        :
//        nil
//    }
    
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
                        alertType?.action() ?? {}()
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
