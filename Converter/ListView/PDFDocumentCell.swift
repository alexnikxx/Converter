//
//  PDFDocumentCell.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct PDFDocumentCell: View {
    let document: PDFFile

    var body: some View {
        VStack {
            Image(systemName: "document.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text(document.title)
                .font(.caption.bold())

            Text(String(describing: document.convertDateToString()))
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(document.fileFormat)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 200, height: 150)
    }
}

#Preview {
    PDFDocumentCell(document: PDFFile(title: "Паспорт", creationDate: Date(), fileFormat: ".pdf", fileURL: URL(fileURLWithPath: "")))
}
