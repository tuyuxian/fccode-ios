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

extension Color {
    static let background = Color("Background")
    static let text = Color("Text")
    static let textHelper = Color("TextHelper")
    static let warning = Color("Warning")
    static let surface1 = Color("Surface1")
    static let surface2 = Color("Surface2")
    static let surface3 = Color("Background")
    static let description = Color("Description")
    
    static let facebook = Color("FB")
    static let google = Color("Google")
    
    static let blue100 = Color("Blue100")
    static let orange60 = Color("Orange60")
    static let orange100 = Color("Orange100")
    static let pink100 = Color("Pink100")
    static let yellow20 = Color("Yellow20")
    static let yellow100 = Color("Yellow100")
}

extension Font {
    static let bigBoldTitle = Font.custom("AzoSans-Bold", size: 40)
    
    static let h1Medium = Font.custom("AzoSans-Medium", size: 28)
    static let h1Regular = Font.custom("AzoSans-Regular", size: 24)
    
    static let h2Medium = Font.custom("AzoSans-Medium", size: 24)
    static let h2Regular = Font.custom("AzoSans-Regular", size: 20)
    
    static let h3Medium = Font.custom("AzoSans-Medium", size: 18)
    static let h3Regular = Font.custom("AzoSans-Regular", size: 18)
    
    static let h4Medium = Font.custom("AzoSans-Medium", size: 14)
    static let h4Regular = Font.custom("AzoSans-Regular", size: 14)
    
    static let pMedium = Font.custom("AzoSans-Medium", size: 14)
    static let pRegular = Font.custom("AzoSans-Regular", size: 14)
    
    static let noteMedium = Font.custom("AzoSans-Medium", size: 12)
    static let noteRegular = Font.custom("AzoSans-Regular", size: 12)
    
    static let captionMedium = Font.custom("AzoSans-Medium", size: 10)
    static let captionRegular = Font.custom("AzoSans-Regular", size: 10)
    
}

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    @ViewBuilder func applyTextColor(_ color: Color) -> some View {
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

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Customize the gestures of navigation bar back button
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
}

// On tap gesture to close the keyboard
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
