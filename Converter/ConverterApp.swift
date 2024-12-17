//
//  ConverterApp.swift
//  Converter
//
//  Created by Aleksandra Nikiforova on 15/12/24.
//

import SwiftUI

@main
struct ConverterApp: App {
    @StateObject private var coreDataController = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, coreDataController.context)
        }
    }
}
