//
//  EntryViewModel.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/25/23.
//

import Foundation

class EntryViewModel: ObservableObject, Equatable {
    static func == (lhs: EntryViewModel, rhs: EntryViewModel) -> Bool {
        return lhs.email == rhs.email
    }
    
    @Published var isNewUser: Bool = true
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmed = ""
    @Published var username: String = ""
    @Published var dateOfBirth: String = ""
    @Published var selectedDate: Date = Date()
    @Published var gender: Gender?
    @Published var nationality = [CountryModel]()
    @Published var ethnicity = [Ethnicity]()
    @Published var avatarUrl: String?
    @Published var isQualified: Bool = false
    @Published var yearIndex = 99
    @Published var monthIndex = Calendar.current.component(.month, from: Date()) - 1
    @Published var dayIndex = Calendar.current.component(.day, from: Date()) - 1
    
    
    
    
}
