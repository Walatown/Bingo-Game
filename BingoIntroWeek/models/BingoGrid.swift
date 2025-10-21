//
//  BingoGrid.swift
//  BingoIntroWeek
//
//  Created by Magda Tsekova on 19/02/2025.
// Defines BingoGrid data model

import Foundation

public struct BingoGrid {
        var challenges: [Challenge]
        
        init() {
            let numbers = BingoGrid.generateBingoNumbers()
            self.challenges = numbers.map { number in
                Challenge(
                    id: number,
                    number: number,
                    isChecked: number == 12, // FREE space is pre-checked
                    challenge: CHALLENGES[number] ?? "Free Space"
                )
            }
        }
        
        static func generateBingoNumbers() -> [Int] {
            var numbers = Array(1...25).filter { $0 != 12 }
            numbers.shuffle()
            numbers.insert(12, at: 12) // Insert FREE at the center
            return numbers
        }
    }
    
    let CHALLENGES: [Int: String] = [
        
        0: "Already regretting their major",
        1: "Has curly hair",
        2: "Wearing sunglasses indoors",
        3: "Wearing colorful socks",
        4: "Not from Bulgaria",
        5: "Looks like they regret signing up",
        6: "Delulu energy",
        7: "Flexing their water bottle",
        8: "Abusing TikTok for 5 hours daily",
        9: "Wearing an outfit screaming virgin",
        10: "Dressed like it’s a job interview",
        11: "Acting like the main character",
        12: "Dramatically sipping from a straw",
        13: "Holding backpack like it’s top secret",
        14: "Laughing but didn’t hear the joke",
        15: "Tried Duolingo but gave up.",
        16: "Already giving up",
        17: "Pretending they know where they're going.",
        18: "Acting",
        19: "Mentally unstable",
        20: "Standing in the room looking lost",
        21: "Avoiding eye contact",
        22: "Wearing the wrong outfit",
        23: "Regretting their shoes"
    ]

