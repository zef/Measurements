//
//  models.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation
import SwiftUI
import CoreData

extension BaseEntity {
    private func updateTimestamps(date: Date = Date()) {
        // return early if the last update just happened
        if let updatedAt, updatedAt.timeIntervalSinceNow > -0.5 {
            return
        }

        updatedAt = date
        createdAt = createdAt ?? updatedAt
        parentObjects.forEach { $0.updateTimestamps(date: date) }
    }

    @objc var parentObjects: [BaseEntity] {
        []
    }

    public override func willSave() {
        updateTimestamps()
    }

    var displayName: String {
        name ?? createdAt?.formatted(date: .numeric, time: .omitted) ?? ""
    }

    var sortDate: Date {
        updatedAt ?? Date()
    }
}

extension Collection {
    static func all(in moc: NSManagedObjectContext) -> [Collection] {
        let request: NSFetchRequest<Collection> = NSFetchRequest(entityName: "Collection")
        return (try? moc.fetch(request)) ?? []
    }

    var itemList: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted {
            $0.sortDate < $1.sortDate
        }
    }

    var itemCount: Int {
        items?.count ?? 0
    }

    public override func didSave() {
        super.didSave()
    }
}

extension Item {
    override var parentObjects: [BaseEntity] {
        [collection].compactMap { $0 }
    }

    var measurementList: [Measurement] {
        let set = measurements as? Set<Measurement> ?? []
        return set.sorted {
            $0.sortDate < $1.sortDate
        }
    }

    @MainActor static func fetchRequest(for collection: Collection) -> FetchRequest<Item> {
        return FetchRequest<Item>(
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Collection.updatedAt, ascending: true)
            ],
            predicate: NSPredicate(format: "collection = %@", collection)
        )
    }
}


//class Measurement: Identifiable {
//    static var longFormatter: MeasurementFormatter = {
//        let formatter = MeasurementFormatter()
//        formatter.unitStyle = .long
//        formatter.unitOptions = .providedUnit
//        return formatter
//    }()
//
//    var name: String?
//    var value: Double
//    var unit: Dimension = UnitLength.inches
//
//    var displayValue: String {
//        let measurement = Foundation.Measurement(value: value, unit: unit)
//        return Measurement.longFormatter.string(from: measurement)
//    }
//
//    var id: UUID {
//        UUID()
//    }
//}


//extension Collection {
//    static var kitchen: Collection {
//        var kitchen = Collection(name: "Kitchen")
//        var sink = Object(name: "Sink")
//        sink.measurements = [
//            Measurement(name: "Width", value: 36),
//            Measurement(value: 18)
//        ]
//
//        kitchen.objects = [
//            sink,
//            Object(name: "Island")
//        ]
//        return kitchen
//    }
//    static var sampleList: [Collection] {
//        return [
//            kitchen,
//            Collection(name: "Part")
//        ]
//    }
//}
