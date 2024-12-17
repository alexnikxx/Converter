//
//  ListView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    NavigationLink {
                        NewDocumentView()
                    } label: {
                        NewDocumentCell()
                    }
                    .buttonStyle(PlainButtonStyle())

                    ForEach(viewModel.coreDataManager.savedDocs, id: \.id) { document in
                        NavigationLink {

                        } label: {
                            PDFDocumentCell(document: document)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}
