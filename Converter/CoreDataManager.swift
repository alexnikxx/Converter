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
    @Published var savedDocs: [PDFFile] = []

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
            let documents = try context.fetch(fetchRequest)
            savedDocs = documents.compactMap { transformToPDF($0) }
            savedDocs.sort(by: { $0.creationDate > $1.creationDate} )
        } catch let error {
            print("Error fetching documents: \(error.localizedDescription)")
        }
    }

    func addDoc(from pdf: PDFFile) {
        let newDoc = PDFDocumentEntity(context: context)
        newDoc.id = pdf.id
        newDoc.title = pdf.title
        newDoc.fileFormat = pdf.fileFormat
        newDoc.creationDate = pdf.creationDate
        newDoc.thumbnail = pdf.convertThumbnailToData()

        saveContext()
    }

    func deleteDoc(_ doc: PDFFile) {
        let fetchRequest = NSFetchRequest<PDFDocumentEntity>(entityName: "PDFDocumentEntity")

        do {
            let documents = try context.fetch(fetchRequest)
            if let document = documents.first(where: { $0.id == doc.id}) {
                deleteFile(with: doc.id)
                context.delete(document)
                saveContext()
            } else {
                print("File not found")
            }
        } catch let error {
            print("Error deleting: \(error.localizedDescription)")
        }

        saveContext()
    }

    private func deleteFile(with id: UUID) {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error getting directory")
            return
        }

        let url = directory.appendingPathComponent("\(id).pdf")

        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.removeItem(at: url)
                print("File deleted: \(url.path)")
            } catch let error {
                print("Error deleting file: \(error.localizedDescription)")
            }
        } else {
            print("File doesn't exist")
        }
    }

    private func transformToPDF(_ entity: PDFDocumentEntity) -> PDFFile? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let id = entity.id else {
            print("Error getting directory")
            return nil
        }

        guard let thumbnailData = entity.thumbnail,
              let thumbnail = UIImage(data: thumbnailData) else {
            print("Error getting thumbnail")
            return nil
        }

        let url = directory.appendingPathComponent("\(id).pdf")
        return PDFFile(
            id: id,
            title: entity.title ?? "Unknown",
            creationDate: entity.creationDate ?? Date(),
            fileFormat: entity.fileFormat ?? ".pdf",
            fileURL: url,
            thumbnail: thumbnail
        )
    }
}
