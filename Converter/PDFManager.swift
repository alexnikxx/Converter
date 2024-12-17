//
//  PDFManager.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI
import PDFKit

final class PDFManager {
    let context = CoreDataManager.shared.context

    let format = UIGraphicsPDFRendererFormat()
    let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)

    func createPDF(with images: [UIImage], title: String, completion: @escaping (PDFFile) -> Void) {
        let metaData = [
            kCGPDFContextTitle: title,
            kCGPDFContextAuthor: "ConverterApp"
        ]
        format.documentInfo = metaData as [String: Any]
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { (context) in
            for image in images {
                addPage(for: image, context: context)
            }
        }

        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfURL = documentsDirectory.appendingPathComponent("\(title).pdf")

            do {
                try data.write(to: pdfURL)
                print("PDF saved: \(pdfURL)")

                let file = PDFFile(
                    id: UUID(),
                    title: title,
                    creationDate: Date(),
                    fileFormat: ".pdf",
                    fileURL: pdfURL
                )

                completion(file)
            } catch let error {
                print("Error writing data into PDF: \(error.localizedDescription)")
            }
        }
    }

    private func addPage(for image: UIImage, context: UIGraphicsPDFRendererContext) {
        context.beginPage()
        let imageSize = image.size

        let scaleWidth = pageRect.width / imageSize.width
        let scaleHeight = pageRect.height / imageSize.height
        let scale = min(scaleWidth, scaleHeight)

        let scaledWidth = imageSize.width * scale
        let scaledHeight = imageSize.height * scale

        let x = (pageRect.width - scaledWidth) / 2
        let y = (pageRect.height - scaledHeight) / 2
        let centeredRect = CGRect(x: x, y: y, width: scaledWidth, height: scaledHeight)

        image.draw(in: centeredRect)
    }
}
