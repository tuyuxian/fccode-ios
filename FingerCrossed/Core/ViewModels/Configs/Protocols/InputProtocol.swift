//
//  InputProtocol.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/19/23.
//

import Foundation

/// A protocol for input validation functions.
public protocol InputProtocol {
    // MARK: - Input Validation functions
    func isEmailValid(str: String) -> Bool
    func isPasswordValid(str: String) -> Bool
    func checkLength(str: String) -> Bool
    func checkUpper(str: String) -> Bool
    func checkLower(str: String) -> Bool
    func checkNumber(str: String) -> Bool
    func checkSymbols(str: String) -> Bool
}

extension InputProtocol {
    /// Email regex
    /// Rules
    /// - simplified RFC5322
    public func isEmailValid(
        str: String
    ) -> Bool {
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: str)
    }
    
    /// Password regex
    /// Rules
    /// - 8 - 36 characters
    /// - at least 1 uppercase
    /// - at least 1 lowercase
    /// - at least 1 number
    /// - at least 1 symbol (!&^%$#@()/_*+-)
    public func isPasswordValid(
        str: String
    ) -> Bool {
        // swiftlint: disable line_length
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!&^%$#@()/_*+-])[A-Za-z\\d!&^%$#@()/_*+-]{8,36}$"
        // swiftlint: enable line_length
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: str)
    }
    
    /// Check length is within 8 - 36 characters
    public func checkLength(
        str: String
    ) -> Bool {
        return str.count >= 8 && str.count <= 36
    }
    
    /// Check if string contain any uppercase
    public func checkUpper(
        str: String
    ) -> Bool {
        return str.contains { $0.isUppercase }
    }
    
    /// Check if string contain any lowercase
    public func checkLower(
        str: String
    ) -> Bool {
        return str.contains { $0.isLowercase }
    }
    
    /// Check if string contain any number
    public func checkNumber(
        str: String
    ) -> Bool {
        return str.contains { $0.isNumber }
    }
    
    /// Check if string contain any symbols
    ///  - Symbols: !&^%$#@()/_*+-
    public func checkSymbols(
        str: String
    ) -> Bool {
        let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
        let symbolChecker = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        guard symbolChecker.evaluate(with: str) else { return false }
        return true
    }
}
