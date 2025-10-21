//
//  ContentView.swift
//  BingoIntroWeek
//
//  Created by Polina Terentjeva on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showIntroView = false

    var body: some View {
        Group {
            if showIntroView {
                IntroView()
            } else {
                AnimatedIntroView(showIntroView: $showIntroView)
            }
        }
        .transition(.opacity) // Smooth transition
        .animation(.easeInOut(duration: 0.5), value: showIntroView)
    }
}
