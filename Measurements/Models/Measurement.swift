//
//  Measurement.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Measurement: Identifiable {
    var name: String?
    var value: Double
    var unit: Dimension = UnitLength.inches

    var displayValue: String {
        return "\(value)\(unit.abbreviation)"
    }

    var id: UUID {
        UUID()
    }
}
