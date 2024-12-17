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

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }

            Button {
                viewModel.showingImagePicker = true
            } label: {
                Text("Выбрать изображения")
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: viewModel.inputImages) { _ in viewModel.loadImages() }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(images: $viewModel.inputImages)
        }
        .toolbar {
            Button("Сохранить") {
                
            }
        }
    }
}

#Preview {
    NewDocumentView()
}
