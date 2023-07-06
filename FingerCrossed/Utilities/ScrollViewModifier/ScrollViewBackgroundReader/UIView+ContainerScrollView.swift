//
//  UIView+ContainerScrollView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/29/23.
//

import UIKit

extension UIView {
    /// Returns the first (closest) `UIScrollView` parent of the receiver.
    ///
    /// This property returns `nil` if no scrollview is found.
    var enclosingScrollView: UIScrollView? {
        sequence(first: self, next: { $0.superview })
            .first(where: { $0 is UIScrollView }) as? UIScrollView
    }
}
