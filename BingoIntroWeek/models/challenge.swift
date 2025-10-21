//
//  challenge.swift
//  BingoIntroWeek
//
//  Created by Magda Tsekova on 19/02/2025.
//

// Defines Challenge data model

import Foundation

struct Challenge: Identifiable {
    let id: Int
    let number: Int
    var isChecked: Bool
    let challenge: String
}
