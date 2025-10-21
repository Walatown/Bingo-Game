//
//  colors.swift
//  BingoIntroWeek
//
//  Created by Polina Terentjeva on 21/02/2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let red, green, blue, alpha: Double
        switch hex.count {
        case 6: // RGB (No alpha)
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
            alpha = 1.0
        case 8: // RGBA
            red = Double((int >> 24) & 0xFF) / 255.0
            green = Double((int >> 16) & 0xFF) / 255.0
            blue = Double((int >> 8) & 0xFF) / 255.0
            alpha = Double(int & 0xFF) / 255.0
        default:
            red = 0
            green = 0
            blue = 0
            alpha = 1.0
        }

        self = Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}


struct AppColors {
    static let primary = Color(hex: "#663366")
    static let secondary = Color(hex: "#E5007D")
    static let lightpurple = Color(hex: "#a384a3")
    static let background = Color(hex: "#663366")
}

