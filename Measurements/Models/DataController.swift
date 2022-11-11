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

        let item = Item(context: viewContext)
        item.name = "Door"
        item.collection = collection

        let m1 = Measurement(context: viewContext)
        m1.name = "width"
        m1.value = 42
        m1.unit = .inches
        m1.item = item

        let m2 = Measurement(context: viewContext)
        m2.name = "height"
        m2.value = 49.5
        m2.unit = .inches
        m2.item = item


        let m3 = Measurement(context: viewContext)
        m3.name = "tare weight"
        m3.value = 338
        m3.unit = .grams
        m3.item = item

        return result
    }()

}
