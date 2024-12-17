//
//  PDFDocumentCell.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct PDFDocumentCell: View {
    let document: PDFDocument

    var body: some View {
        VStack {
            document.thumnail
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
    PDFDocumentCell(document: PDFDocument(title: "Паспорт", creationDate: Date(), thumnail: Image(systemName: "document.fill"), fileFormat: ".pdf"))
}
