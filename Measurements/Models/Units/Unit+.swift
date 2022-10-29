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

protocol SpecificUnit: Dimension, Identifiable {
    associatedtype Element: SpecificUnit

    static var dimensions: [Element] { get }
    //    static var metricDimensions: [Element] { get }
    //    static var saeDimensions: [Element] { get }
}

extension SpecificUnit {
    var isMetric: Bool {
        Self.metricDimensions.contains { $0 == self }
    }
    var isSAE: Bool {
        Self.saeDimensions.contains { $0 == self }
    }
    static var metricDimensions: [Element] { [] }
    static var saeDimensions: [Element] { [] }
}

//extension UnitLength: SpecificUnit {
//    static var dimensions: [UnitLength] {
//        [
//            .inches,
//            .feet,
//            .millimeters,
//            .centimeters,
//            .meters,
//            .yards,
//            .kilometers,
//            .miles,
//        ]
//    }
//    static var metricDimensions: [UnitLength] {
//        [.meters, .millimeters, .centimeters, .kilometers]
//    }
//
//    static var saeDimensions: [UnitLength] {
//        [.inches, .feet, .yards]
//    }
//}
//
//extension UnitMass: SpecificUnit {
//    static var dimensions: [UnitMass] {
//        [
//            .milligrams,
//            .grams,
//            .ounces,
//            .kilograms,
//            .pounds,
//        ]
//    }
//
//    static var metricDimensions: [UnitMass] {
//        [.milligrams, .grams, .kilograms]
//    }
//
//    static var saeDimensions: [UnitMass] {
//        [.ounces, .pounds]
//    }
//}
//
//extension UnitTemperature: SpecificUnit {
//    static var dimensions: [UnitTemperature] {
//        [
//            .fahrenheit,
//            .celsius,
//            .kelvin
//        ]
//    }
//
//    static var metricDimensions: [UnitTemperature] {
//        [.celsius]
//    }
//    static var saeDimensions: [UnitTemperature] {
//        [.fahrenheit]
//    }
//}


extension UnitAcceleration: SpecificUnit {
    static var dimensions: [UnitAcceleration] {
        [
            .metersPerSecondSquared,
            .gravity
        ]
    }
}


extension UnitAngle: SpecificUnit {
    static var dimensions: [UnitAngle] {
        [
            .degrees,
            .arcMinutes,
            .arcSeconds,
            .radians,
            .gradians,
            .revolutions
        ]
    }
}


extension UnitArea: SpecificUnit {
    static var dimensions: [UnitArea] {
        [
            .squareMegameters,
            .squareKilometers,
            .squareMeters,
            .squareCentimeters,
            .squareMillimeters,
            .squareMicrometers,
            .squareNanometers,
            .squareInches,
            .squareFeet,
            .squareYards,
            .squareMiles,
            .acres,
            .ares,
            .hectares
        ]
    }
}


extension UnitConcentrationMass: SpecificUnit {
    static var dimensions: [UnitConcentrationMass] {
        [
            .gramsPerLiter,
            .milligramsPerDeciliter
        ]
    }
}

extension UnitDispersion: SpecificUnit {
    static var dimensions: [UnitDispersion] {
        [
            .partsPerMillion
        ]
    }
}


extension UnitDuration: SpecificUnit {
    static var dimensions: [UnitDuration] {
        [
            .hours,
            .minutes,
            .seconds,
            .milliseconds,
            .microseconds,
            .nanoseconds,
            .picoseconds
        ]
    }
}


extension UnitElectricCharge: SpecificUnit {
    static var dimensions: [UnitElectricCharge] {
        [
            .coulombs,
            .megaampereHours,
            .kiloampereHours,
            .ampereHours,
            .milliampereHours,
            .microampereHours
        ]
    }
}


extension UnitElectricCurrent: SpecificUnit {
    static var dimensions: [UnitElectricCurrent] {
        [
            .megaamperes,
            .kiloamperes,
            .amperes,
            .milliamperes,
            .microamperes
        ]
    }
}


extension UnitElectricPotentialDifference: SpecificUnit {
    static var dimensions: [UnitElectricPotentialDifference] {
        [
            .megavolts,
            .kilovolts,
            .volts,
            .millivolts,
            .microvolts
        ]
    }
}


extension UnitElectricResistance: SpecificUnit {
    static var dimensions: [UnitElectricResistance] {
        [
            .megaohms,
            .kiloohms,
            .ohms,
            .milliohms,
            .microohms
        ]
    }
}


extension UnitEnergy: SpecificUnit {
    static var dimensions: [UnitEnergy] {
        [
            .kilojoules,
            .joules,
            .kilocalories,
            .calories,
            .kilowattHours
        ]
    }
}

extension UnitFrequency: SpecificUnit {
    static var dimensions: [UnitFrequency] {
        [
            .terahertz,
            .gigahertz,
            .megahertz,
            .kilohertz,
            .hertz,
            .millihertz,
            .microhertz,
            .nanohertz,
            .framesPerSecond
        ]
    }
}


extension UnitFuelEfficiency: SpecificUnit {
    static var dimensions: [UnitFuelEfficiency] {
        [
            .litersPer100Kilometers,
            .milesPerImperialGallon,
            .milesPerGallon
        ]
    }
}


extension UnitInformationStorage: SpecificUnit {
    static var dimensions: [UnitInformationStorage] {
        [
            .bytes,
            .bits, .nibbles,
            .yottabytes, .zettabytes, .exabytes, .petabytes, .terabytes, .gigabytes, .megabytes, .kilobytes,
            .yottabits, .zettabits, .exabits, .petabits, .terabits, .gigabits, .megabits, .kilobits,
            .yobibytes, .zebibytes, .exbibytes, .pebibytes, .tebibytes, .gibibytes, .mebibytes, .kibibytes,
            .yobibits, .zebibits, .exbibits, .pebibits, .tebibits, .gibibits, .mebibits, .kibibits
        ]
    }
}


extension UnitLength: SpecificUnit {
    static var dimensions: [UnitLength] {
        [
            .megameters,
            .kilometers,
            .hectometers,
            .decameters,
            .meters,
            .decimeters,
            .centimeters,
            .millimeters,
            .micrometers,
            .nanometers,
            .picometers,
            .inches,
            .feet,
            .yards,
            .miles,
            .scandinavianMiles,
            .lightyears,
            .nauticalMiles,
            .fathoms,
            .furlongs,
            .astronomicalUnits,
            .parsecs
        ]
    }
}



extension UnitIlluminance: SpecificUnit {
    static var dimensions: [UnitIlluminance] {
        [
            .lux
        ]
    }
}


extension UnitMass: SpecificUnit {
    static var dimensions: [UnitMass] {
        [
            .kilograms,
            .grams,
            .decigrams,
            .centigrams,
            .milligrams,
            .micrograms,
            .nanograms,
            .picograms,
            .ounces,
            .pounds,
            .stones,
            .metricTons,
            .shortTons,
            .carats,
            .ouncesTroy,
            .slugs
        ]
    }
}


extension UnitPower: SpecificUnit {
    static var dimensions: [UnitPower] {
        [
            .terawatts,
            .gigawatts,
            .megawatts,
            .kilowatts,
            .watts,
            .milliwatts,
            .microwatts,
            .nanowatts,
            .picowatts,
            .femtowatts,
            .horsepower
        ]
    }
}


extension UnitPressure: SpecificUnit {
    static var dimensions: [UnitPressure] {
        [
            .newtonsPerMetersSquared,
            .gigapascals,
            .megapascals,
            .kilopascals,
            .hectopascals,
            .inchesOfMercury,
            .bars,
            .millibars,
            .millimetersOfMercury,
            .poundsForcePerSquareInch
        ]
    }
}


extension UnitSpeed: SpecificUnit {
    static var dimensions: [UnitSpeed] {
        [
            .metersPerSecond,
            .kilometersPerHour,
            .milesPerHour,
            .knots

        ]
    }
}


extension UnitTemperature: SpecificUnit {
    static var dimensions: [UnitTemperature] {
        [
            .kelvin,
            .celsius,
            .fahrenheit
        ]
    }
}

extension UnitVolume: SpecificUnit {
    static var dimensions: [UnitVolume] {
        [
            .megaliters,
            .kiloliters,
            .liters,
            .deciliters,
            .centiliters,
            .milliliters,
            .cubicKilometers,
            .cubicMeters,
            .cubicDecimeters,
            .cubicCentimeters,
            .cubicMillimeters,
            .cubicInches,
            .cubicFeet,
            .cubicYards,
            .cubicMiles,
            .acreFeet,
            .bushels,
            .teaspoons,
            .tablespoons,
            .fluidOunces,
            .cups,
            .pints,
            .quarts,
            .gallons,
            .imperialTeaspoons,
            .imperialTablespoons,
            .imperialFluidOunces,
            .imperialPints,
            .imperialQuarts,
            .imperialGallons,
            .metricCups
        ]
    }
}
