//
//  models.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

extension BaseEntity {
    var displayName: String {
        name ?? createdAt?.formatted(date: .numeric, time: .omitted) ?? ""
    }

    var sortDate: Date {
        updatedAt ?? Date()
    }

    func updateTimestamps() {
        updatedAt = Date()

        if createdAt == nil {
            createdAt = updatedAt
        }
    }
}

extension Collection {
    var itemList: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted {
            $0.sortDate < $1.sortDate
        }
    }
}

extension Item {
    var measurementList: [Measurement] {
        let set = measurements as? Set<Measurement> ?? []
        return set.sorted {
            $0.sortDate < $1.sortDate
        }
    }
}


extension Measurement {
    var displayValue: String {
        "\(value)"
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
