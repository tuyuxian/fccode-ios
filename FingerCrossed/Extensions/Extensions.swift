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
    static let surface3 = Color("Surface3")
    static let surface4 = Color("Surface4")
    static let description = Color("Description")
    
    static let facebook = Color("FB")
    static let google = Color("Google")
    
    static let blue20 = Color("Blue20")
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
    
    static let pMedium = Font.custom("AzoSans-Medium", size: 14)
    static let pRegular = Font.custom("AzoSans-Regular", size: 14)
    
    static let noteMedium = Font.custom("AzoSans-Medium", size: 12)
    static let noteRegular = Font.custom("AzoSans-Regular", size: 12)
    
    static let captionMedium = Font.custom("AzoSans-Medium", size: 10)
    static let captionRegular = Font.custom("AzoSans-Regular", size: 10)
    
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
            guard let url = self.url(forResource: file, withExtension: nil) else {
                fatalError("Failed to locate \(file) in bundle.")
            }

            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load \(file) from bundle.")
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy

            do {
                return try decoder.decode(T.self, from: data)
            } catch DecodingError.keyNotFound(let key, let context) {
                fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
            } catch DecodingError.typeMismatch(_, let context) {
                fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(_) {
                fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
            } catch {
                fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            }
        }
}

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
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
