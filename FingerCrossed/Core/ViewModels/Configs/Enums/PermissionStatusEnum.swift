//
//  PermissionStatusEnum.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/21/23.
//

import Foundation

public enum PermissionStatus {
    /// The explicitly allowed or `authorized` permission state
    case authorized
    /// The explicitly denied permission state
    case denied
    /// The state in which the user has granted limited access permission (ex. photos)
    case limited
    /// The temporary allowed state that limits the app's access (ex. allow once)
    case temporary
    /// The `notDetermined` permission state, and the only state where it is possible to ask permission
    case notDetermined
}
