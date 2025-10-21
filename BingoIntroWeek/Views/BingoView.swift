//
//  BingoView.swift
//  BingoIntroWeek
//
//  Created by Magda Tsekova on 19/02/2025.


// Main UI screen and preview

import SwiftUI
import CodeScanner

struct BingoView: View {
    @State private var bingoGrid = BingoGrid()
    @State private var showAlert = false
    @State private var selectedChallenge: Challenge?
    @State private var isShowingScanner = false
    @State private var isScanned = false
    @State private var isCardVisible = false // Track card visibility
    @State private var cardOffset: CGFloat = UIScreen.main.bounds.height // Track card position

    @State private var isShowingQRGenerator = false

    
    var body: some View {
        ZStack {
            // Background Color
            AppColors.primary
                .ignoresSafeArea()


            VStack {
                // TOP HEADER (Home Button & Points)
                HStack {
                    
                    Spacer()
                    
                    Text("1,550")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .italic()
                        .padding(8)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                
                // 🔥 CHALLENGE SECTION (Evenly Spaced)
                VStack(spacing: 10) {
                    if let challenge = selectedChallenge {
                        Group {
                            if challenge.isChecked {
                                Image(systemName: "checkmark") // Checkmark if completed
                                    .font(.system(size: 40, weight: .bold))
                            } else {
                                Text("\(challenge.number)") // Challenge number if not completed
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 75, height: 75)
                        .background(AppColors.secondary)
                        .clipShape(Circle())
                    }
                    
                    Text("Find someone who is...")
                        .font(.system(size: 20, weight: .bold))
                        .italic()
                        .foregroundColor(AppColors.lightpurple)
                    
                    Text("\(selectedChallenge?.challenge ?? "No available challenges!")")
                        .font(.system(.largeTitle).weight(.bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40) // ✅ Ensures equal spacing

                
                Spacer()
                
            }

            // Bottom Section (Buttons + Slide-Up Card)
            VStack {
                Spacer() // Push everything to the bottom

                // Slide-Up Card
                VStack {
                    
                    
                    // Bingo Grid Popup
                    BingoGridView(bingoGrid: $bingoGrid)
                        .frame(height: 400) // Set a fixed height for the card
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .offset(y: cardOffset) // Control the card's position
                        .animation(.easeInOut, value: cardOffset) // Animate the card's movement
                    
                }
               
                
                Button(action: { isShowingScanner = true }) {
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 120, height: 120)
                }
                .fullScreenCover(isPresented: $isShowingScanner) {
                    CodeScannerView(
                        codeTypes: [.qr],
                        simulatedData: "John Doe\njohn.doe@example.com",
                        completion: handleScan
                    )
                }
                
                // BOTTOM BUTTONS
                Button(action: {
                    if let challenge = getRandomChallenge() {
                        selectedChallenge = challenge // Update the selected challenge
                        isScanned = false
                    } else {
                        showAlert = true // Show an alert if no challenges are available
                    }
                }) {
                    Text("NEXT")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .clipShape(Capsule())
                }

                // Hint to Slide Up
                                
                    Text("Slide anywhere to view bingo card")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(10)
                        .italic()

            }

        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    // Only respond to upward swipes
                    if value.translation.height < 0 {
                        cardOffset = max(0, value.translation.height)
                    }
                }
                .onEnded { value in
                    // Snap the card to the top or bottom based on swipe direction
                    if value.translation.height < -100 {
                        cardOffset = 0 // Show the card
                        isCardVisible = true
                    } else {
                        cardOffset = UIScreen.main.bounds.height // Hide the card
                        isCardVisible = false
                    }
                }
        )

        .onAppear {
            selectedChallenge = getRandomChallenge()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("BINGO!"), message: Text("You win! 🎉"), dismissButton: .default(Text("OK")))
        }
    }

    // Handle QR Code Scan
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success:
            isScanned = true
            
            if let challenge = selectedChallenge,
               let index = bingoGrid.challenges.firstIndex(where: { $0.id == challenge.id }) {
                bingoGrid.challenges[index].isChecked = true
                
                if selectedChallenge?.id == bingoGrid.challenges[index].id {
                    selectedChallenge?.isChecked = true
                }
            }
            
            DispatchQueue.main.async {
                if checkBingo() {
                    showAlert = true
                }

                selectedChallenge = getRandomChallenge()

            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    // Check for a winning combination
    private func checkBingo() -> Bool {
        let winningCombinations = [
            [0, 1, 2, 3, 4], [5, 6, 7, 8, 9], [10, 11, 12, 13, 14],
            [15, 16, 17, 18, 19], [20, 21, 22, 23, 24],
            [0, 5, 10, 15, 20], [1, 6, 11, 16, 21], [2, 7, 12, 17, 22],
            [3, 8, 13, 18, 23], [4, 9, 14, 19, 24],
            [0, 6, 12, 18, 24], [4, 8, 12, 16, 20]
        ]
        
        return winningCombinations.contains { combination in
            combination.allSatisfy { index in
                bingoGrid.challenges[index].isChecked
            }
        }
    }

    // Get a random challenge
    private func getRandomChallenge() -> Challenge? {
        let availableChallenges = bingoGrid.challenges.filter { !$0.isChecked && $0.id != 12 }
        return availableChallenges.randomElement()
    }
}

#Preview {
    BingoView()
}
