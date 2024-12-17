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

    func convertDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: creationDate)
    }
}
