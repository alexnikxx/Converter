//
//  ReadDocumentView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct ReadDocumentView: View {
    @StateObject private var viewModel = ReadDocumentViewModel()
    let url: URL

    var body: some View {
        VStack {
            PDFKitView(url: url)
        }
        .toolbar {
            Button {
                viewModel.sharePDF(url: url)
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}
