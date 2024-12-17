//
//  QRCodeView.swift
//  sport
//
//  Created by pc on 02.10.24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    // MARK: - Properties
    private let uniqueID: String = {
        if let savedID = UserDefaults.standard.string(forKey: UserDefaultsKeys.uniqueID) {
            return savedID
        }
        let newID = UUID().uuidString
        UserDefaults.standard.set(newID, forKey: UserDefaultsKeys.uniqueID)
        return newID
    }()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            qrCodeImage
                .padding(.horizontal, 32)
            
            titleText
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Views
    private var qrCodeImage: some View {
        generateQRCode(from: uniqueID)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 220, height: 220)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(UIColor.label))
                    .shadow(color: .black.opacity(0.1), radius: 10)
            )
    }
    
    private var titleText: some View {
        Text("Your Discount QR Code")
            .font(.title2.bold())
            .foregroundColor(.primary)
    }
    
    // MARK: - Methods
    private func generateQRCode(from string: String) -> Image {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel") // Highest error correction
        
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return Image(systemName: "xmark.circle")
        }
        
        // Create a transformed, larger QR code
        let size = CGSize(width: 220, height: 220)
        let scale = min(size.width / outputImage.extent.width,
                       size.height / outputImage.extent.height)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let uiImage = renderer.image { context in
            UIImage(cgImage: cgImage).draw(in: CGRect(origin: .zero, size: size))
        }
        
        return Image(uiImage: uiImage)
    }
}

// MARK: - Constants
enum UserDefaultsKeys {
    static let uniqueID = "qrUniqueID"
    static let soundEnabled = "soundEnabled"
}

#Preview {
    NavigationView {
        QRCodeView()
    }
    .preferredColorScheme(.dark)
}
