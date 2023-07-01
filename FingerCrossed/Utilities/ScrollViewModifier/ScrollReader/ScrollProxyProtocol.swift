//
//  ScrollProxyProtocol.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/29/23.
//

import Foundation
import SwiftUI

/// The proxy protocol declares the programmatic scrolling methods we can use on the scrollview.
protocol ScrollProxyProtocol {
    /// Scrolls to a child view with the specified identifier.
    ///
    /// - Parameter identifier: The unique scroll identifier of the child view.
    /// - Parameter anchor: The unit point anchor to describe which edge of the child view
    /// should be snap to.
    func scroll(to identifier: AnyHashable, anchor: UnitPoint)
    /// Scrolls to a child view with the specified identifier and adjusted by the offset position.
    ///
    /// - Parameter identifier: The unique scroll identifier of the child view.
    /// - Parameter anchor: The unit point anchor to describe which edge of the child view
    /// should be snap to.
    /// - Parameter offset: Extra offset on top of the identified view's position.
    func scroll(to identifier: AnyHashable, anchor: UnitPoint, offset: CGPoint)
}
