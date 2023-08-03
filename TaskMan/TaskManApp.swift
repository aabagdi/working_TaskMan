//
//  TaskManApp.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/1/23.
//

import SwiftUI

@main
struct TaskManApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
