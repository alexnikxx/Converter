//
//  NewDocumentViewModel.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

final class NewDocumentViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared
    let pdfManager = PDFManager()
    @Published var images: [UIImage] = []
    @Published var showingImagePicker = false
    @Published var inputImages: [UIImage] = []
    @Published var title: String = ""

    func loadImages() {
        images = inputImages
    }

    func saveDocument(images: [UIImage], title: String) {
        pdfManager.createPDF(with: images, title: title) { pdf in
            self.coreDataManager.addDoc(from: pdf)
        }
    }
}
