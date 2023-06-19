//
//  Sheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/31/23.
//

import SwiftUI

struct Sheet<Header: View, Content: View, Footer: View>: View, KeyboardReadable {
    
    @State var size: Set<PresentationDetent>
    
    @State var showDragIndicator: Bool = true
        
    @State var hasHeader: Bool = true
    
    @State var hasFooter: Bool = true
    
    @ViewBuilder var header: Header
    
    @ViewBuilder var content: Content
    
    @ViewBuilder var footer: Footer
    
    @State private var sheetContentHeight = CGFloat(0)
    
    @State private var isKeyboardShowUp: Bool = false
    
    var body: some View {
        ScrollView([]) {
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    showDragIndicator
                    ? Capsule()
                        .fill(Color.surface1)
                        .opacity(0.5)
                        .frame(width: 35, height: 5)
                        .padding(.top, 10)
                    : nil
                    hasHeader
                    ? header
                    : nil
                }
                content
            }
        }
//        .readHeight()
//        .onPreferenceChange(HeightPreferenceKey.self) { height in
//            print(height)
//            if let height {
//                self.sheetContentHeight = height
//            }
//        }
//        .presentationDetents([.height(self.sheetContentHeight - (isKeyboardShowUp ? 34 : 0))])
        .presentationDetents(size)
        .scrollDismissesKeyboard(.immediately)
        .safeAreaInset(
            edge: .bottom,
            content: { hasFooter ? footer : nil }
        )
        .padding(.horizontal, 24)
        .onReceive(keyboardPublisher) { val in
            isKeyboardShowUp = val
        }
    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        Sheet(
            size: [.medium],
            header: {},
            content: {},
            footer: {
                PrimaryButton(
                    label: "Save",
                    action: {},
                    isTappable: .constant(true),
                    isLoading: .constant(false)
                )
                .padding(.horizontal, 24)
            }
        )
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(
        value: inout CGFloat?,
        nextValue: () -> CGFloat?
    ) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: HeightPreferenceKey.self,
                value: geometry.size.height
            )
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readHeight() -> some View {
        self
            .modifier(ReadHeightModifier())
    }
}
