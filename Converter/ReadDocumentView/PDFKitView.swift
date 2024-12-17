//
//  PDFKitView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    @StateObject var viewModel = ReadDocumentViewModel()
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        pdfView.document = PDFDocument(url: self.url)

        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {

    }
}
