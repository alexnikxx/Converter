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
            let id = UUID()
            let pdfURL = documentsDirectory.appendingPathComponent("\(id).pdf")

            do {
                try data.write(to: pdfURL)
                print("PDF saved: \(pdfURL)")

                let file = PDFFile(
                    id: id,
                    title: title,
                    creationDate: Date(),
                    fileFormat: ".pdf",
                    fileURL: pdfURL,
                    thumbnail: createThumbnail(from: pdfURL)
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

    private func createThumbnail(from url: URL) -> UIImage {
        guard let pdfDocument = PDFDocument(url: url),
              let page = pdfDocument.page(at: 0) else {
            print("Failed to create thumbnail for PDF at \(url)")
            return UIImage(systemName: "doсument.fill") ?? UIImage()
        }

        let pageRect = page.bounds(for: .mediaBox)
        let scale = 80 / pageRect.width
        let scaledSize = CGSize(width: pageRect.width * scale, height: pageRect.height * scale)

        UIGraphicsBeginImageContextWithOptions(scaledSize, true, 0)
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(origin: .zero, size: scaledSize))

        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(2.0)
        context.stroke(CGRect(origin: .zero, size: scaledSize))

        context.saveGState()
        context.translateBy(x: 0, y: scaledSize.height)
        context.scaleBy(x: 1, y: -1)
        context.scaleBy(x: scale, y: scale)

        page.draw(with: .mediaBox, to: context)
        context.restoreGState()

        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return thumbnail ?? UIImage(systemName: "doсument.fill") ?? UIImage()
    }
}
