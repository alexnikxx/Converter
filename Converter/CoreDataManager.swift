//
//  CoreDataManager.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "Converter")
    @Published var savedDocs: [PDFDocument] = []

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }

        fetchDocs()
    }

    func fetchDocs() {
        let fetchRequest = NSFetchRequest<PDFDocument>(entityName: "PDFfile")
        do {
            savedDocs = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error fetching documents: \(error.localizedDescription)")
        }
    }

    func addDoc(title: String) {
        let newDoc = PDFDocument(context: container.viewContext)
        newDoc.title = title
        newDoc.fileFormat = ".pdf"
        newDoc.creationDate = Date()
//        newDoc.fileURL = URL(fileURLWithPath: "")
//        newDoc.thumbnail = 

        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchDocs()
        } catch let error {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
