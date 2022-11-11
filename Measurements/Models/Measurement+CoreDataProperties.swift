//
//  Measurement+CoreDataProperties.swift
//  Measurements
//
//  Created by Zef Houssney on 11/10/22.
//
//

import Foundation
import CoreData


extension Measurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement> {
        return NSFetchRequest<Measurement>(entityName: "Measurement")
    }

    @NSManaged private var unitName: String?
    @NSManaged public var note: String?
    @NSManaged public var value: Double
    @NSManaged public var item: Item?

    public var unit: Dimension.Case? {
        get {
            guard let unitName,
                    let value = Dimension.Case(rawValue: unitName) else {
                return nil
            }
            return value
        }
        set {
            self.unitName = newValue?.rawValue
        }
    }

    override var parentObjects: [BaseEntity] {
        [item].compactMap { $0 }
    }

    var displayValue: String {
        if let unit {
            let formatter = MeasurementFormatter()
            formatter.unitOptions = .providedUnit
            formatter.unitStyle = .long
            let measurement = Foundation.Measurement(value: value, unit: unit.unit)
            return formatter.string(from: measurement)
//            return "\(value) \(unit.description)"
        } else {
            return String(value)
        }
    }
}
