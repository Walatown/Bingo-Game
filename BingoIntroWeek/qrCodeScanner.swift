//
//  qrCodeScanner.swift
//  BingoIntroWeek
//
//  Created by Polina Terentjeva on 19/02/2025.
//
// Followed tutorial: https://www.hackingwithswift.com/books/ios-swiftui/scanning-qr-codes-with-swiftui


import SwiftData
import SwiftUI
import CodeScanner

// Define the Prospect model for SwiftData
@Model
final class Prospect: Identifiable {
    var id = UUID()
    var name: String
    var emailAddress: String
    var isContacted: Bool

    init(name: String, emailAddress: String, isContacted: Bool = false) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}

struct QRCodeScannerView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State private var isShowingScanner = false
    @State private var isShowingQRGenerator = false

    var body: some View {
        VStack {
            Button("Scan QR Code") {
                // Show the scanner when the button is tapped
                isShowingScanner = true
            }
            .sheet(isPresented: $isShowingScanner) {
                // QR code scanner view
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                    completion: handleScan
                )
            }

            Button("Generate QR Code") {
                isShowingQRGenerator = true
            }
            .sheet(isPresented: $isShowingQRGenerator) {
                // QR code generation view
                QRView()
            }
        }
    }

    // Handle the scan result
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            // Insert the person into your model context
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
