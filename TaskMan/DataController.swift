//
//  DataController.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 8/2/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "TaskDataModel")
    
    init() {
        try! container.initializeCloudKitSchema(options: [])
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Container descriptions not loaded")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
