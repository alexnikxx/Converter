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
    @State var showingTitleTextField = false

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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Сохранение невозможно"), message: Text("Изображения не выбраны"), dismissButton: .cancel())
        }
        .alert("Сохранение PDF", isPresented: $showingTitleTextField) {
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
                if viewModel.images.isEmpty {
                    showingAlert = true
                } else {
                    showingTitleTextField = true
                }
            }
        }
    }
}

#Preview {
    NewDocumentView()
}
