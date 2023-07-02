//
//  ActionSheetModifier.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/28/23.
//

import SwiftUI

struct ActionSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    let description: String
    let actionButtonList: [ActionButton]
    
    init(isPresented: Binding<Bool>, description: String, actionButtonList: [ActionButton]) {
        _isPresented = isPresented
        self.description = description
        self.actionButtonList = actionButtonList
    }
    
    func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(isPresented: $isPresented, content: {
                ActionSheet(
                    isPresented: $isPresented,
                    description: description,
                    actionButtonList: actionButtonList
                )
            })
    }
}

extension View {
    func actionSheet(
        isPresented: Binding<Bool>,
        description: String,
        actionButtonList: [ActionButton]
    ) -> some View {
        modifier(ActionSheetModifier(
            isPresented: isPresented,
            description: description,
            actionButtonList: actionButtonList)
        )
    }
}
