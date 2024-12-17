//
//  PDFDocument.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct PDFFile: Identifiable {
    let id: UUID
    let title: String
    let creationDate: Date
    let fileFormat: String
    let fileURL: URL
    let thumbnail: UIImage

    func convertDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: creationDate)
    }

    func convertThumbnailToData() -> Data {
        guard let data = thumbnail.jpegData(compressionQuality: 0.8) else {
            print("Couldn't convert image to data")
            return Data()
        }

        return data
    }
}
