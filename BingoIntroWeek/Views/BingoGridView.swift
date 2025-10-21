//
//  BingoGrid.swift
//  BingoIntroWeek
//
//  Created by Magda Tsekova on 25/02/2025.
//

import SwiftUI

struct BingoGridView: View {
    @Binding var bingoGrid: BingoGrid
    
    var body: some View {
        ZStack {
            // Background Color
            AppColors.primary
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                // "B I N G O" Header
                HStack(spacing: 11) {
                    ForEach(["B", "I", "N", "G", "O"], id: \.self) { letter in
                        Text(letter)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(AppColors.primary)
                            .frame(width: 60, height: 50)
                            .background(AppColors.lightpurple)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                // Bingo Grid
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 5),
                    spacing: 8
                ) {
                    ForEach(bingoGrid.challenges) { challenge in
                        BingoCell(challenge: challenge)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    BingoGridView(bingoGrid: .constant(BingoGrid()))
}
