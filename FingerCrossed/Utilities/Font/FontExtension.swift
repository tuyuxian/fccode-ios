//
//  FontExtension.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/7/23.
//

import SwiftUI

enum AppFonts {
    case bigBoldTitle
    case h1Medium
    case h1Regular
    case h2Medium
    case h2Regular
    case h3Medium
    case h3Regular
    case h3Bold
    case h4Medium
    case h4Regular
    case pSemibold
    case pMedium
    case pRegular
    case captionMedium
    case captionRegular
    case noteMedium
    case noteRegular
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
            
        case .h3Bold:
            return FontTemplate(font: Font.system(size: 18), weight: .bold, size: 18, lineHeight: 24)

        case .h4Medium:
            return FontTemplate(font: Font.system(size: 14), weight: .medium, size: 14, lineHeight: 20)
            
        case .h4Regular:
            return FontTemplate(font: Font.system(size: 14), weight: .regular, size: 14, lineHeight: 20)
        
        case .pSemibold:
            return FontTemplate(font: Font.system(size: 16), weight: .semibold, size: 16, lineHeight: 24)
            
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
