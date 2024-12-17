//
//  PDFManager.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI
import PDFKit

final class PDFManager {
    let format = UIGraphicsPDFRendererFormat()
    let metaData = [
        kCGPDFContextTitle: "Hello, World!",
        kCGPDFContextAuthor: "John Doe"
    ]

    let context = CoreDataManager.shared.context

    func createPDF(with images: [UIImage], title: String, completion: @escaping (PDFFile) -> Void) {
        format.documentInfo = metaData as [String: Any]
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            for (index, image) in images.enumerated() {
                context.beginPage()

                let imageRect = CGRect(x: 0, y: CGFloat(index * 850), width: 595, height: 850)
                image.draw(in: imageRect)
            }
        }

        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfURL = documentsDirectory.appendingPathComponent("\(title).pdf")

            do {
                try data.write(to: pdfURL)
                print("PDF saved: \(pdfURL.path)")

                let file = PDFFile(
                    title: title,
                    creationDate: Date(),
                    fileFormat: ".pdf"
                )

                completion(file)
            } catch let error {
                print("Error writing data into PDF: \(error.localizedDescription)")
            }
        }
    }
}
