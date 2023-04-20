//
//  FontTemplate.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/19/23.
//

import Foundation
import SwiftUI


public class FontTemplate: FontTemplating {
    
    private var id: UUID
    public var font: Font
    public var size: CGFloat
    public var weight: Font.Weight
    public var lineHeight: CGFloat
    public init(font: Font,
                weight: Font.Weight,
                size: CGFloat,
                lineHeight: CGFloat) {
        self.id = UUID()
        self.font = font
        self.weight = weight
        self.size = size
        self.lineHeight = lineHeight
    }
}

struct FontTemplateModifier: ViewModifier {
    let template: FontTemplating
    let uiFont: UIFont
    
    init(template: FontTemplating, uiFont: UIFont) {
        self.template = template
        self.uiFont = UIFont.systemFont(ofSize: template.size)
    }
    func body(content: Content) -> some View {
        content
            .font(template.font
                    .weight(template.weight))
            .lineSpacing(template.lineHeight - uiFont.lineHeight)
            .padding(.vertical, (template.lineHeight - uiFont.lineHeight) / 2)
    }
}

//struct AppFontTemplate {
//
//    static let h1Medium = FontTemplate(font: Font.system(size: 28), weight: .medium, size: 28, lineHeight: 40)
//    static let h1Regular = FontTemplate(font: Font.system(size: 28), weight: .regular, size: 28, lineHeight: 40)
//
//    static let h2Medium = FontTemplate(font: Font.system(size: 24), weight: .medium, size: 24, lineHeight: 34)
//    static let h2Regular = FontTemplate(font: Font.system(size: 20), weight: .regular, size: 20, lineHeight: 28)
//
//    static let h3Medium = FontTemplate(font: Font.system(size: 18), weight: .medium, size: 18, lineHeight: 24)
//    static let h3Regular = FontTemplate(font: Font.system(size: 18), weight: .regular, size: 18, lineHeight: 24)
//
//
//
//}
