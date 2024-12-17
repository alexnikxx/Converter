//
//  ContentView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import SwiftUI
import PhotosUI

struct NewDocumentView: View {
    @StateObject private var viewModel = NewDocumentViewModel()
    @State var showingAlert = false

    var body: some View {
        VStack {
            if viewModel.images.isEmpty {
                Text("Выберите изображения из галереи, нажав на плюс в правом верхнем углу")
                    .multilineTextAlignment(.center)
            } else {
                ScrollView(.vertical) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
        .padding()
        .onChange(of: viewModel.inputImages) { _ in viewModel.loadImages() }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(images: $viewModel.inputImages)
        }
        .alert("Important message", isPresented: $showingAlert) {
            TextField("Введите название", text: $viewModel.title)
            Button("Отменить", role: .cancel) { }
            Button("Сохранить") {
                viewModel.saveDocument(images: viewModel.images, title: viewModel.title)
            }
        }
        .toolbar {
            Button {
                viewModel.showingImagePicker = true
            } label: {
                Image(systemName: "plus")
            }

            Button("Сохранить") {
                showingAlert = true
            }
        }
    }
}

#Preview {
    NewDocumentView()
}
