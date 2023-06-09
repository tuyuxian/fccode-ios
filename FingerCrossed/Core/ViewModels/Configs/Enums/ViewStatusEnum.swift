//
//  ViewStatusEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/4/23.
//

import Foundation

public enum ViewStatus {
    /// default view status
    case none
    /// status to show shimmer or page spinner
    case loading
    /// status after successfully fetch data
    case complete
    /// status if error occur
    case error
}
