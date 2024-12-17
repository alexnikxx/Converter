//
//  ContentView.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import SwiftUI
import PhotosUI

struct NewDocumentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            ZStack {
                Text("Select an image")

                image?
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
        .onTapGesture {
            showingImagePicker = true
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    NewDocumentView()
}
