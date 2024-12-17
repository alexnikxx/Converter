//
//  ReadDocumentView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct ReadDocumentView: View {
    let url: URL

    var body: some View {
        PDFKitView(url: url)
    }
}

#Preview {
    ReadDocumentView(url: Bundle.main.url(forResource: "sample", withExtension: "pdf")!)
}
