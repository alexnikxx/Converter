//
//  NewDocumentViewModel.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import SwiftUI

final class NewDocumentViewModel: ObservableObject {
    @State var images: [UIImage] = []
    @State var showingImagePicker = false
    @State var inputImages: [UIImage] = []

    func loadImages() {
        images = inputImages
    }
}
