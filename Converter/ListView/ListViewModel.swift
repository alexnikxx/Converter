//
//  ListViewModel.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 17/12/24.
//

import Foundation

final class ListViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared

    func deleteDoc(document: PDFFile) {
        coreDataManager.deleteDoc(document)
    }
}
