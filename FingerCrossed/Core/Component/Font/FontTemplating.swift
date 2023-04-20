//
//  FontTemplating.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/19/23.
//

import SwiftUI

public protocol FontTemplating {
    var font: Font { get }
    var weight: Font.Weight { get }
    var size: CGFloat { get }
    var lineHeight: CGFloat { get }
}
