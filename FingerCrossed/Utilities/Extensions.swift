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

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        clipShape(
            RoundedCorner(
                radius: radius,
                corners: corners
            )
        )
    }
    
    public func fontTemplate(
        _ template: FontTemplating
    ) -> some View {
        modifier(
            FontTemplateModifier(
                template: template,
                uiFont: UIFont.systemFont(ofSize: template.size)
            )
        )
    }

    func fontTemplate(_ template: AppFonts) -> some View {
        self.fontTemplate(
            Template.get(
                font: template
            )
        )
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(
                UIResponder.resignFirstResponder
            ),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    func transparentFullScreenCover<Content: View>(
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        modifier(TransparentFullScreenModifier(
            isPresented: isPresented,
            fullScreenContent: content)
        )
    }
}

// Transparent full screen cover background
private struct TransparentFullScreenModifier<FullScreenContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let fullScreenContent: () -> (FullScreenContent)
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { _ in
                UIView.setAnimationsEnabled(false)
            }
            .fullScreenCover(isPresented: $isPresented,
                             content: {
                ZStack {
                    fullScreenContent()
                }
                .background(FullScreenCoverBackgroundRemovalView())
                .onAppear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
                .onDisappear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
            })
            .transaction({ transaction in transaction.disablesAnimations = true })
                // add custom animation for presenting and dismissing the FullScreenCover
            .animation(.linear(duration: 0.5), value: isPresented)
    }
    
}

private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {
    
    private class BackgroundRemovalView: UIView {
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
        }
        
    }
    
    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(
        in rect: CGRect
    ) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius,
            height: radius)
        )
        return Path(path.cgPath)
    }
}

// Customize the gestures of navigation bar back button
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    var rootViewController: UIViewController? {
        return viewControllers.first
    }

    public func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

extension View {
    public func haptics(
        _ style: UIImpactFeedbackGenerator.FeedbackStyle
    ) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
