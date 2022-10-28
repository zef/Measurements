//
//  Measurement.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Measurement: Identifiable {
    static var longFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        formatter.unitOptions = .providedUnit
        return formatter
    }()

    var name: String?
    var value: Double
    var unit: Dimension = UnitLength.inches

    var displayValue: String {
        let measurement = Foundation.Measurement(value: value, unit: unit)
        return Measurement.longFormatter.string(from: measurement)
    }

    var id: UUID {
        UUID()
    }
}
