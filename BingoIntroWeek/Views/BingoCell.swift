//
//  BingoCell.swift
//  BingoIntroWeek
//
//  Created by Magda Tsekova on 19/02/2025.
//

// Bingo Cell component

import SwiftUI

struct BingoCell: View {
    let challenge: Challenge

    var body: some View {
        ZStack {
            // 🔥 Background Color: Changes when checked
            RoundedRectangle(cornerRadius: 10)
                .fill(challenge.isChecked ? AppColors.secondary : Color.white)
                .frame(width: 60, height: 50)
                .shadow(radius: 2)

            // 🔥 FREE SPACE Cell (Darker Purple)
            if challenge.number == 12 {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.secondary)
                    .frame(width: 60, height: 50)
            }

            // 🔥 Text: Gray by default, turns white when checked
            Text(challenge.number == 12 ? "FREE" : "\(challenge.number)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(challenge.isChecked ? .white : .gray)
        }
    }
}


