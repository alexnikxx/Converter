//
//  CoreDataManager.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import SwiftUI
import CoreData

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()

    private let persistedContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    @Published var savedDocs: [PDFDocument] = []

    private init() {
        persistedContainer = NSPersistentContainer(name: "Converter")
        persistedContainer.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            } else {
                guard let url = description.url else { return }
                print("DB url - ", url.absoluteString)
            }
        }

        context = persistedContainer.viewContext
        fetchDocs()
    }

    private func saveContext() {
        let context = persistedContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                fetchDocs()
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }

    func fetchDocs() {
        let fetchRequest = NSFetchRequest<PDFDocumentEntity>(entityName: "PDFDocumentEntity")
        do {
            let documents = try persistedContainer.viewContext.fetch(fetchRequest)
            savedDocs = documents.map { transformToPDF($0) }
        } catch let error {
            print("Error fetching documents: \(error.localizedDescription)")
        }
    }

    func addDoc() {
        let newDoc = PDFDocumentEntity(context: persistedContainer.viewContext)
        newDoc.title = "Document\(Date())"
        newDoc.fileFormat = ".pdf"
        newDoc.creationDate = Date()
        //        newDoc.fileURL = URL(fileURLWithPath: "")
        //        newDoc.thumbnail =

        saveContext()
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func transformToPDF(_ entity: PDFDocumentEntity) -> PDFDocument {
        let thumbnailImage: Image
        if let imageData = entity.thumbnail, let uiImage = UIImage(data: imageData) {
            thumbnailImage = Image(uiImage: uiImage)
        } else {
            thumbnailImage = Image(systemName: "doc.plaintext") // Default placeholder
        }

        return PDFDocument(
            title: entity.title ?? "Unknown",
            creationDate: entity.creationDate ?? Date(),
            thumnail: thumbnailImage,
            fileFormat: entity.fileFormat ?? ".pdf"
        )
    }
}
