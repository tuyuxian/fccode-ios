//
//  Icon.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/11/23.
//

import SwiftUI

public enum FCIcon: String {
    // MARK: Heart
    case brokenHeart = "BrokenHeart"
    case brokenHeartPink = "BrokenHeartPink"
    case brokenHeartWhite = "BrokenHeartWhite"
    case heart = "Heart"
    case heartPink = "heartPink"
    case heartWhite = "heartWhite"
    
    // MARK: Media
    // - Audio
    case mic = "Mic"
    case pause = "Pause"
    case play = "Play"
    case stop = "Stop"
    // - Photo
    case addPicture = "AddPicture"
    case addPictureMedium = "AddPictureMedium"
    case camera = "Camera"
    case picture = "Picture"
    case pictureMedium = "PictureMedium"
    
    // MARK: Selection
    case checkbox = "CheckBox"
    case checkboxSelected = "CheckBoxSelected"
    case checkCirle = "CheckCircle"
    case radio = "Radio"
    case radioSelected = "RadioSelected"
    
    // MARK: Social Media
    case apple = "Apple"
    case facebook = "Fb"
    case google = "Google"
    
    // MARK: Tab
    case chat = "Chat"
    case pairing = "Pairing"
    case profile = "Profile"
    
    // MARK: System
    case ageWhite = "AgeWhite"
    case drag = "Drag"
    case dragIndicator = "DragIndicator"
    case edit = "Edit"
    case errorCircle = "ErrorCircle"
    case errorCircleRed = "ErrorCircleRed"
    case eyeClose = "EyeClose"
    case eyeOpen = "EyeShow"
    case genderWhite = "GenderWhite"
    case globe = "Globe"
    case globeWhite = "GlobeWhite"
    case infoCircle = "InfoCircle"
    case location = "Location"
    case locationWhite = "locationWhite"
    case more = "More"
    case moreWhite = "MoreWhite"
    case search = "Search"
    case sent = "Sent"
    case trash = "Trash"
    case warning = "Warning"
    // - Close
    case close = "Close"
    case closeCircleRed = "CloseCircleRed"
    case closeCircleYellow = "CloseCircleYellow"
    case cloesWhite = "CloseWhite"
    // - Basic Arrows
    case arrowDown = "ArrowDown"
    case arrowLeft = "ArrowLeft"
    case arrowRight = "ArrowRight"
    case arrowUp = "ArrowUp"
    // - Circle Arrows
    case arrowDownCircle = "ArrowDownCircle"
    case arrowLeftCircle = "ArrowLeftCircle"
    case arrowRightCircle = "ArrowRightCircle"
    case arrowUpCircle = "ArrowUpCircle"
}

extension FCIcon: View {
    public var body: Image {
        Image(rawValue)
    }
    
    func resizable() -> Image {
        self.body.resizable()
    }
}
