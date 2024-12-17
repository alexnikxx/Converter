//
//  PDFManager.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

final class PDFManager {
    func exportToPDF() {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let rootVC = UIApplication.shared.windows.first?.rootViewController

        //Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        DispatchQueue.main.async {
            do {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    rootVC?.view.layer.render(in: context.cgContext)
                })
                print("wrote file to: \(outputFileURL.path)")
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
}
