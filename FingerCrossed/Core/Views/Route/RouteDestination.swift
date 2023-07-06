//
//  RouteDestination.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import SwiftUI

public enum ProfileDestination: Hashable {
    case basicInfo
    case helpSupport
    case preference
    case settings
}

public enum BasicInfoDestination: Hashable {
    case basicInfoSelfIntro
    case basicInfoVoiceMessage
}

public enum PreferenceDestination: Hashable {
    case preferenceAge
    case preferenceDistance
    case preferenceEthnicity
    case preferenceGoal
    case preferenceNationality
    case preferenceSexOrientation
}

public enum SettingsDestination: Hashable {
    case settingsAccount
    case settingsResetPassword
}
