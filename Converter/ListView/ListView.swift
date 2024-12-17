//
//  ListView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    @State private var showingAlert = false
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
                            ReadDocumentView(url: document.fileURL)
                        } label: {
                            PDFDocumentCell(document: document)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            Button {

                            } label: {
                                Label("Поделиться", systemImage: "square.and.arrow.up")
                            }

                            Button {
                                viewModel.deleteDoc(document: document)
                            } label: {
                                Label("Удалить", systemImage: "trash")
                            }

                            Button {

                            } label: {
                                Label("Объединить", systemImage: "document.on.document")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ваши PDF")
        }
    }
}

#Preview {
    ListView()
}
