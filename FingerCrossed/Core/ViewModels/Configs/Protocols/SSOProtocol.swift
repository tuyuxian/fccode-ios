//
//  SSOProtocol.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation
import UIKit

public typealias SSOSuccess = ((String?) -> Void)
public typealias SSOFailure = ((Error?) -> Void)

/// The protocol for sso manager.
public protocol SSOProtocol {
    func signIn(successAction: @escaping SSOSuccess, errorAction: @escaping SSOFailure)
    func signOut()
}
