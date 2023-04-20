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

//extension Font {
//    
//    static let bigBoldTitle = Font.custom("AzoSans-Bold", size: 40)
//    
//    static let h1Medium = Font.custom("AzoSans-Medium", size: 28)
//    static let h1Regular = Font.custom("AzoSans-Regular", size: 24)
//    
//    static let h2Medium = Font.custom("AzoSans-Medium", size: 24)
//    static let h2Regular = Font.custom("AzoSans-Regular", size: 20)
//    
//    static let h3Medium = Font.custom("AzoSans-Medium", size: 18)
//    static let h3Regular = Font.custom("AzoSans-Regular", size: 18)
//    
//    static let pMedium = Font.custom("AzoSans-Medium", size: 14)
//    static let pRegular = Font.custom("AzoSans-Regular", size: 14)
//    
//    static let noteMedium = Font.custom("AzoSans-Medium", size: 12)
//    static let noteRegular = Font.custom("AzoSans-Regular", size: 12)
//    
//    static let captionMedium = Font.custom("AzoSans-Medium", size: 10)
//    static let captionRegular = Font.custom("AzoSans-Regular", size: 10)
//    
//}
enum AppFonts {
    case bigBoldTitle, h1Medium, h1Regular, h2Medium, h2Regular, h3Medium, h3Regular, h4Medium, h4Regular, pMedium, pRegular, captionMedium, captionRegular, noteMedium, noteRegular
}

struct Template {
    static func get(font: AppFonts) -> FontTemplate {
        switch font {
        case .bigBoldTitle:
            return FontTemplate(font: Font.system(size: 40), weight: .heavy, size: 40, lineHeight: 50)
            
        case .h1Medium:
            return FontTemplate(font: Font.system(size: 28), weight: .medium, size: 28, lineHeight: 40)
            
        case .h1Regular:
            return FontTemplate(font: Font.system(size: 28), weight: .regular, size: 28, lineHeight: 40)
            
        case .h2Medium:
            return FontTemplate(font: Font.system(size: 24), weight: .medium, size: 24, lineHeight: 34)
            
        case .h2Regular:
            return FontTemplate(font: Font.system(size: 20), weight: .regular, size: 20, lineHeight: 28)
            
        case .h3Medium:
            return FontTemplate(font: Font.system(size: 18), weight: .medium, size: 18, lineHeight: 24)
            
        case .h3Regular:
            return FontTemplate(font: Font.system(size: 18), weight: .regular, size: 18, lineHeight: 24)

        case .h4Medium:
            return FontTemplate(font: Font.system(size: 14), weight: .medium, size: 14, lineHeight: 20)
            
        case .h4Regular:
            return FontTemplate(font: Font.system(size: 14), weight: .regular, size: 14, lineHeight: 20)

        case .pMedium:
            return FontTemplate(font: Font.system(size: 16), weight: .medium, size: 16, lineHeight: 20)
            
        case .pRegular:
            return FontTemplate(font: Font.system(size: 16), weight: .regular, size: 16, lineHeight: 25)
            
        case .noteMedium:
            return FontTemplate(font: Font.system(size: 12), weight: .medium, size: 12, lineHeight: 16)
            
        case .noteRegular:
            return FontTemplate(font: Font.system(size: 12), weight: .regular, size: 12, lineHeight: 16)
            
        case .captionMedium:
            return FontTemplate(font: Font.system(size: 10), weight: .medium, size: 10, lineHeight: 14)
            
        case .captionRegular:
            return FontTemplate(font: Font.system(size: 10), weight: .regular, size: 10, lineHeight: 14)
        
        }
    }
}

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    public func fontTemplate(_ template: FontTemplating) -> some View {
        modifier(FontTemplateModifier(template: template, uiFont: UIFont.systemFont(ofSize: template.size)))
        }

    func fontTemplate(_ template: AppFonts) -> some View {
            self.fontTemplate(Template.get(font: template))
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
