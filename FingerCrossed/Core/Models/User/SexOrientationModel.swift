//
//  SexOrientationModel.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/29/23.
//

import Foundation

struct SexOrientation: Equatable {
    public var id: UUID = UUID()
    public var type: SexOrientationType
    
    init(
        type: SexOrientationType
    ) {
        self.type = type
    }
}
