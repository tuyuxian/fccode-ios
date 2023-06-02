//
//  Sheet.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/31/23.
//

import SwiftUI

struct Sheet<Content: View, Footer: View>: View {
    
    @State var size: Set<PresentationDetent>?
    
    @State var showDragIndicator: Bool = true
        
    @State var hasHeader: Bool = true
    
    @State var hasFooter: Bool = true
    
    @State var header: String?
    
    @ViewBuilder var content: Content
    
    @ViewBuilder var footer: Footer
    
    @State private var sheetContentHeight = CGFloat(0)
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    showDragIndicator
                    ? Capsule()
                        .fill(Color.secondary)
                        .opacity(0.5)
                        .frame(width: 35, height: 5)
                        .padding(.top, 10)
                    : nil
                    hasHeader
                    ? Text(header!)
                        .fontTemplate(.h2Medium)
                        .foregroundColor(Color.text)
                        .frame(height: 34)
                        .multilineTextAlignment(.center)
                    : nil
                }
                content
            }
            .background {
                GeometryReader { proxy in
                    Color.white
                        .task {
                            sheetContentHeight = proxy.size.height
                        }
                }
            }
            .presentationDetents(size ?? [.height(sheetContentHeight)])
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
            hasHeader: false,
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
