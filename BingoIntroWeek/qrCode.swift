//
//  qrCode.swift
//  BingoIntroWeek
//
//  Created by Polina Terentjeva on 19/02/2025.
//  Followed the tutorial: https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code
//

import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

struct QRView: View {
    @AppStorage("name") private var name = "John"
    @AppStorage("emailAddress") private var emailAddress = "john.doe@example.com"
    @Environment(\.dismiss) private var dismiss  // <--- This allows dismissal
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                // Display the QR code image
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                // **Add a Close Button**
                Button("Close") {
                    dismiss()  // <--- This will close the fullScreenCover
                }
                .font(.headline)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitle("QR Code", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()  // <--- This also closes the view
                    }
                }
            }
        }
    }
    
    // Function to generate QR code
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRView()
}
