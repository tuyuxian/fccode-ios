//
//  Extensions.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/27/23.
//  Modified by Yu-Hsien Tu on 4/6/23.
//

import Foundation
import SwiftUI
import UIKit

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        clipShape(
            RoundedCorner(
                radius: radius,
                corners: corners
            )
        )
    }
    
    public func fontTemplate(
        _ template: FontTemplating
    ) -> some View {
        modifier(
            FontTemplateModifier(
                template: template,
                uiFont: UIFont.systemFont(ofSize: template.size)
            )
        )
    }

    func fontTemplate(_ template: AppFonts) -> some View {
        self.fontTemplate(
            Template.get(
                font: template
            )
        )
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(
                UIResponder.resignFirstResponder
            ),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    @ViewBuilder func applyTextColor(
        _ color: Color
    ) -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
          self.colorInvert().colorMultiply(color)
        } else {
          self.colorMultiply(color)
        }
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(
        in rect: CGRect
    ) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius,
            height: radius)
        )
        return Path(path.cgPath)
    }
}

// Customize the gestures of navigation bar back button
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    var rootViewController: UIViewController? {
        return viewControllers.first
    }

    public func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}
