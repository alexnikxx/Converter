//
//  ReadDocumentViewModel.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import Foundation

final class ReadDocumentViewModel: ObservableObject {
    func sharePDF(url: URL) {
        PDFManager.sharePDF(fileURL: url)
    }
}
