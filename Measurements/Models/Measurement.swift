//
//  Measurement.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Measurement: Identifiable {
    enum Unit {
        case inch
        case millimeter

        var unitType: UnitLength {
            switch self {
            case .inch:
                return UnitLength.inches
            case .millimeter:
                return UnitLength.millimeters
            }
        }

        var abbreviation: String {
            switch self {
            case .inch:
                return "\""
            default:
                return unitType.symbol
            }
        }
    }

    var name: String?
    var value: Double
    var unit: Unit = .inch

    var displayValue: String {
        return "\(value)\(unit.abbreviation)"
    }

    var id: UUID {
        UUID()
    }
}
