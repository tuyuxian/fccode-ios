//
//  Sheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/31/23.
//

import SwiftUI

struct Sheet<Header: View, Content: View, Footer: View>: View {
    
    @State var size: Set<PresentationDetent>
    
    @State var showDragIndicator: Bool = true
        
    @State var hasHeader: Bool = true
    
    @State var hasFooter: Bool = true
    
    @ViewBuilder var header: Header
    
    @ViewBuilder var content: Content
    
    @ViewBuilder var footer: Footer
    
    @State private var sheetContentHeight = CGFloat(0)
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.white.edgesIgnoringSafeArea(.all)
            
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
            .ignoresSafeArea(.keyboard)
            .presentationDetents(size)
            .scrollDismissesKeyboard(.immediately)
            .safeAreaInset(
                edge: .bottom,
                content: { hasFooter ? footer : nil }
            )
            .padding(.horizontal, 24)
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
