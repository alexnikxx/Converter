//
//  ConverterApp.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import SwiftUI

@main
struct ConverterApp: App {
    @StateObject private var coreDataController = CoreDataManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
