//
//  DataController.swift
//  Measurements
//
//  Created by Zef Houssney on 10/28/22.
//

import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    let container = NSPersistentCloudKitContainer(name: "Measurements")

    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print("CoreData failed to load stores.", error)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        do {
            try container.viewContext.save()
        } catch {
            assertionFailure("Save Failed \(error)")
        }
    }

    static var preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.container.viewContext

        let collection = Collection(context: viewContext)
        collection.name = "House Stuff"

        let item = Item(context: preview.container.viewContext)
        item.name = "Door"
        item.collection = collection

        result.save()
        return result
    }()

}
