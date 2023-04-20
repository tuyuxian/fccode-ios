//
//  FontTemplate.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/19/23.
//

import Foundation
import SwiftUI


public class FontTemplate {
    private var id: UUID
    public var font: Font
    public var size: CGFloat
    public var weight: Font.Weight
    public init(font: Font,
                weight: Font.Weight,
                size: CGFloat) {
        self.id = UUID()
        self.font = font
        self.weight = weight
        self.size = size
    }
}

//struct FontTemplateModifier: ViewModifier {
////    let template: FontTemplate
//////    let uiFont: UIFont
//////    let lineHeight: CGFloat
////    
////    init(template: FontTemplate) {
////        self.template = template
////    }
////    
////    func body(content: Content) -> some View {
////        content
////            .font(template.font
////                    .weight(template.weight))
////            .lineSpacing(lineHeight - uiFont.lineHeight)
////            .padding(.vertical, (lineHeight - uiFont.lineHeight) / 2)
////    }
//}
