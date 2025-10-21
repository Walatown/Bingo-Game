//
//  IntroModel.swift
//  BingoIntroWeek
//
//  Created by Polina Terentjeva on 26/02/2025.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var gifName: String // Renamed for clarity
    var tag: Int

    var gifURL: URL? {
        return Bundle.main.url(forResource: gifName, withExtension: "gif")
    }

    static var samplePages: [Page] = [
        Page(name: "Get a challenge", description: "The best app to meet friends by completing bingo challenges!", gifName: "challenge", tag: 0),
        Page(name: "Take a picture", description: "Make memories during your intro week and remember them forever!", gifName: "picture", tag: 1),
        Page(name: "Meet new friends", description: "Best friends are made during intro week, don't miss out!", gifName: "bingo", tag: 2),
    ]
}
