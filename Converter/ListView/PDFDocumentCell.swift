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
            Image(uiImage: document.thumbnail)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            Text(document.title)
                .font(.caption.bold())

            Text(String(describing: document.convertDateToString()))
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(document.fileFormat)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 150, height: 150, alignment: .center)
    }
}
