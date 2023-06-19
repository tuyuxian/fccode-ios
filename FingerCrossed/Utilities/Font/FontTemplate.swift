//
//  FontTemplate.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/19/23.
//

import Foundation
import SwiftUI

public protocol FontTemplating {
    var font: Font { get }
    var weight: Font.Weight { get }
    var size: CGFloat { get }
    var lineHeight: CGFloat { get }
}

public class FontTemplate: FontTemplating {
    private var id: UUID
    public var font: Font
    public var size: CGFloat
    public var weight: Font.Weight
    public var lineHeight: CGFloat
    public init(
        font: Font,
        weight: Font.Weight,
        size: CGFloat,
        lineHeight: CGFloat
    ) {
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
    func body(
        content: Content
    ) -> some View {
        content
            .font(template.font.weight(template.weight))
            .lineSpacing(template.lineHeight - uiFont.lineHeight)
            .padding(.vertical, (template.lineHeight - uiFont.lineHeight) / 2)
    }
}
