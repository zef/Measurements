//
//  Unit+.swift
//  Measurements
//
//  Created by Zef Houssney on 10/6/22.
//

import Foundation

extension Unit: Identifiable {
    public var id: String {
        symbol
    }
    var displayName: String {
        symbol
    }
    var abbreviation: String {
        symbol
    }
}

protocol SpecificUnit {
    associatedtype Element: Dimension

//    static var name: String { get }

    static var dimensions: [Element] { get }
    static var metricDimensions: [Element] { get }
    static var saeDimensions: [Element] { get }
}

//extension SpecificUnit: Identifiable {
//    static var id
//}

//extension SpecificUnit {
//    var isMetric: Bool {
//        return Self.metricDimensions.contains(self)
//    }
//    var isSAE: Bool {
//        return Self.saeDimensions.contains(self)
//    }
//}

extension UnitLength: SpecificUnit {
    static var dimensions: [UnitLength] {
        [
            .inches,
            .feet,
            .millimeters,
            .centimeters,
            .meters,
            .yards,
            .kilometers,
            .miles,
        ]
    }
    static var metricDimensions: [UnitLength] {
        [.meters, .millimeters, .centimeters, .kilometers]
    }

    static var saeDimensions: [UnitLength] {
        [.inches, .feet, .yards]
    }
}

extension UnitMass: SpecificUnit {
    static var dimensions: [UnitMass] {
        [
            .milligrams,
            .grams,
            .ounces,
            .kilograms,
            .pounds,
        ]
    }

    static var metricDimensions: [UnitMass] {
        [.milligrams, .grams, .kilograms]
    }

    static var saeDimensions: [UnitMass] {
        [.ounces, .pounds]
    }
}

extension UnitTemperature: SpecificUnit {
    static var dimensions: [UnitTemperature] {
        [
            .fahrenheit,
            .celsius,
            .kelvin
        ]
    }

    static var metricDimensions: [UnitTemperature] {
        [.celsius]
    }
    static var saeDimensions: [UnitTemperature] {
        [.fahrenheit]
    }
}



