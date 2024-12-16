//
//  QRCodeView.swift
//  sport
//
//  Created by pc on 02.10.24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let uniqueID: String = {
        if let savedID = UserDefaults.standard.string(forKey: "uniqueID") {
            return savedID
        } else {
            let newID = UUID().uuidString
            UserDefaults.standard.set(newID, forKey: "uniqueID")
            return newID
        }
    }()

    var body: some View {
        VStack {
            ZStack {
                Image("qr")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)

                Image(uiImage: generateQRCode(from: uniqueID))
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            .padding(.bottom)

            Text("Your Discount QR Code")
                .font(.largeTitle)
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRCodeView()
}
