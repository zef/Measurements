//
//  Measurement.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Measurement: Identifiable {

    enum UnitType: String, CaseIterable, Identifiable {
        case length
        case mass
        case temperature = "temp"

        var name: String {
            rawValue
        }
        var id: String {
            rawValue
        }

        var dimensions: [Foundation.Unit] {
            specificUnitType.dimensions
        }

        var specificUnitType: any SpecificUnit.Type {
            switch self {
            case .length:
                return UnitLength.self
            case .mass:
                return UnitMass.self
            case .temperature:
                return UnitTemperature.self
            }
        }

        func iconName(filled: Bool = true) -> String {
            let name: String

            switch self {
            case .length:
                name = "ruler"
            case .mass:
                name = "scalemass"
            case .temperature:
                return "thermometer"
            }

            if filled {
                return "\(name).fill"
            } else {
                return name
            }
        }
    }

    var name: String?
    var value: Double
    var unit: UnitLength = .inches

    var displayValue: String {
        return "\(value)\(unit.abbreviation)"
    }

    var id: UUID {
        UUID()
    }
}
