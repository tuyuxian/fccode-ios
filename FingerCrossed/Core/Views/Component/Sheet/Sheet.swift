//
//  Sheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/31/23.
//

import SwiftUI

struct Sheet<Header: View, Content: View, Footer: View>: View {
    
    var size: Set<PresentationDetent>
    
    var showDragIndicator: Bool = true
    
//    var 
        
    var hasHeader: Bool = true
    
    var hasFooter: Bool = true
    
    @ViewBuilder var header: Header
    
    @ViewBuilder var content: Content
    
    @ViewBuilder var footer: Footer
            
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
                    ? header.padding(.top, showDragIndicator ? 0 : 30)
                    : nil
                }
                content
            }
        }
        .presentationDetents(size)
        .presentationDragIndicator(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .safeAreaInset(
            edge: .bottom,
            content: { hasFooter ? footer : nil }
        )
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
