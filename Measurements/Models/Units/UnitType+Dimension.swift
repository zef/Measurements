//
//  UnitType+Dimension.swift
//  Measurements
//
//  Created by Zef Houssney on 11/10/22.
//

import Foundation

extension Dimension {
    public enum Case: String, CaseIterable, CustomStringConvertible, Identifiable {
        public var id: Self { self }

        public var description: String {
            rawValue.titleizeCamelCase
        }

        static var defaultCase: Case {
            switch Locale.current.measurementSystem {
            case .us:
                return .inches
            default:
                return .centimeters
            }
        }

        var unitType: UnitType {
            for t in UnitType.allCases {
                if unit.isKind(of: t.type) {
                    return t
                }
            }
            assertionFailure("Expected to find matching UnitType!")
            return .length
        }

        var isUS: Bool {
            switch self {
            case .inches, .feet, .yards, .miles,
                 .squareInches, .squareFeet, .squareYards, .squareMiles, .acres,
                 .cubicInches, .cubicFeet, .cubicYards, .cubicMiles, .acreFeet,
                 .bushels, .teaspoons, .tablespoons, .fluidOunces, .cups,
                 .pints, .quarts, .gallons,
                 .ounces, .pounds, .shortTons,
                 .milesPerHour, .milesPerGallon,
                 .fahrenheit,
                 .inchesOfMercury, .poundsForcePerSquareInch:
                return true
            default:
                return false
            }
        }

        var isUK: Bool {
            if isImperial {
                return true
            }

            switch self {
            case .stones:
                return true
            default:
                return false
            }
        }

        // the odd UK variants, not the entire "imperial" system
        var isImperial: Bool {
            rawValue.lowercased().contains("imperial")
        }

        var isCommon: Bool { !isObscure }

        var isObscure: Bool {
            let exactMatches: [Self] = [
                .ares, .terahertz, .millihertz,
                .nanograms, .nanohertz, .nanowatts,
                .nibbles, .scandinavianMiles,
                .centigrams, .centiliters,
            ]
            return [
                exactMatches.contains(self),
                self.matches("mega", except: [.megabits, .megabytes, .megahertz, .megaohms]),
                self.matches("pico"),
                self.matches("nano", except: [.nanometers, .nanoseconds]),
                self.matches("micro", except: [.microseconds, .microvolts]),
                self.matches("bibytes"),
                self.matches("bibits"),
                self.matches("yotta"),
                self.matches("zetta"),
                self.matches("hecto"),
                self.matches("dec"),
                self.matches("pascal"),
                self.matches("mercury"),
            ].contains(true)
        }

        func matches(_ string: String, except exceptions: [Self] = []) -> Bool {
            if exceptions.contains(self) { return true }
            return rawValue.lowercased().contains(string)
        }

        // Acceleration
        case gravity
        case metersPerSecondSquared

        // Angle
        case degrees
        case radians
        case revolutions
        case arcMinutes
        case arcSeconds
        case gradians

        // Area
        case squareMegameters
        case squareKilometers
        case squareMeters
        case squareCentimeters
        case squareMillimeters
        case squareMicrometers
        case squareNanometers
        case squareInches
        case squareFeet
        case squareYards
        case squareMiles
        case acres
        case ares
        case hectares

        // Concentration Mass
        case gramsPerLiter
        case milligramsPerDeciliter

        // Dispersion
        case partsPerMillion

        // Duration
        case seconds
        case minutes
        case hours
        case milliseconds
        case microseconds
        case nanoseconds
        case picoseconds

        // Electric Charge
        case  ampereHours
        case  coulombs
        case  microampereHours
        case  milliampereHours
        case  kiloampereHours
        case  megaampereHours

        // Electric Current
        case amperes
        case microamperes
        case milliamperes
        case kiloamperes
        case megaamperes

        // Electric Potential Difference
        case volts
        case microvolts
        case millivolts
        case kilovolts
        case megavolts

        // Electric Resistance
        case ohms
        case microohms
        case milliohms
        case kiloohms
        case megaohms

        // Energy
        case joules
        case calories
        case kilowattHours
        case kilojoules
        case kilocalories

        // Frequency
        case hertz
        case gigahertz
        case megahertz
        case kilohertz
        case terahertz
        case millihertz
        case microhertz
        case nanohertz
        case framesPerSecond

        // Fuel Efficiency
        case milesPerGallon
        case litersPer100Kilometers
        case milesPerImperialGallon

        // Information Storage
        case bytes
        case bits
        case nibbles
        case yottabytes
        case zettabytes
        case exabytes
        case petabytes
        case terabytes
        case gigabytes
        case megabytes
        case kilobytes
        case yottabits
        case zettabits
        case exabits
        case petabits
        case terabits
        case gigabits
        case megabits
        case kilobits
        case yobibytes
        case zebibytes
        case exbibytes
        case pebibytes
        case tebibytes
        case gibibytes
        case mebibytes
        case kibibytes
        case yobibits
        case zebibits
        case exbibits
        case pebibits
        case tebibits
        case gibibits
        case mebibits
        case kibibits

        // Length
        case megameters
        case kilometers
        case hectometers
        case decameters
        case meters
        case decimeters
        case centimeters
        case millimeters
        case micrometers
        case nanometers
        case picometers
        case inches
        case feet
        case yards
        case miles
        case scandinavianMiles
        case lightyears
        case nauticalMiles
        case fathoms
        case furlongs
        case astronomicalUnits
        case parsecs

        // Illuminance
        case lux

        // Mass
        case kilograms
        case grams
        case decigrams
        case centigrams
        case milligrams
        case micrograms
        case nanograms
        case picograms
        case ounces
        case pounds
        case stones
        case metricTons
        case shortTons
        case carats
        case ouncesTroy
        case slugs

        // Power
        case terawatts
        case gigawatts
        case megawatts
        case kilowatts
        case watts
        case milliwatts
        case microwatts
        case nanowatts
        case picowatts
        case femtowatts
        case horsepower

        // Pressure
        case poundsForcePerSquareInch
        case bars
        case millibars
        case newtonsPerMetersSquared
        case gigapascals
        case megapascals
        case kilopascals
        case hectopascals
        case inchesOfMercury
        case millimetersOfMercury

        // Speed
        case metersPerSecond
        case kilometersPerHour
        case milesPerHour
        case knots

        // Temperature
        case kelvin
        case celsius
        case fahrenheit

        // Volume
        case teaspoons
        case tablespoons
        case fluidOunces
        case cups
        case pints
        case quarts
        case gallons
        case imperialTeaspoons
        case imperialTablespoons
        case imperialFluidOunces
        case imperialPints
        case imperialQuarts
        case imperialGallons
        case metricCups
        case megaliters
        case kiloliters
        case liters
        case deciliters
        case centiliters
        case milliliters
        case cubicKilometers
        case cubicMeters
        case cubicDecimeters
        case cubicCentimeters
        case cubicMillimeters
        case cubicInches
        case cubicFeet
        case cubicYards
        case cubicMiles
        case acreFeet
        case bushels

        var unit: Foundation.Dimension {
            switch self {
            case .metersPerSecondSquared: return UnitAcceleration.metersPerSecondSquared
            case .gravity: return UnitAcceleration.gravity

            case .degrees: return UnitAngle.degrees
            case .arcMinutes: return UnitAngle.arcMinutes
            case .arcSeconds: return UnitAngle.arcSeconds
            case .radians: return UnitAngle.radians
            case .gradians: return UnitAngle.gradians
            case .revolutions: return UnitAngle.revolutions

            case .squareMegameters: return UnitArea.squareMegameters
            case .squareKilometers: return UnitArea.squareKilometers
            case .squareMeters: return UnitArea.squareMeters
            case .squareCentimeters: return UnitArea.squareCentimeters
            case .squareMillimeters: return UnitArea.squareMillimeters
            case .squareMicrometers: return UnitArea.squareMicrometers
            case .squareNanometers: return UnitArea.squareNanometers
            case .squareInches: return UnitArea.squareInches
            case .squareFeet: return UnitArea.squareFeet
            case .squareYards: return UnitArea.squareYards
            case .squareMiles: return UnitArea.squareMiles
            case .acres: return UnitArea.acres
            case .ares: return UnitArea.ares
            case .hectares: return UnitArea.hectares

            case .gramsPerLiter: return UnitConcentrationMass.gramsPerLiter
            case .milligramsPerDeciliter: return UnitConcentrationMass.milligramsPerDeciliter

            case .partsPerMillion: return UnitDispersion.partsPerMillion

            case .hours: return UnitDuration.hours
            case .minutes: return UnitDuration.minutes
            case .seconds: return UnitDuration.seconds
            case .milliseconds: return UnitDuration.milliseconds
            case .microseconds: return UnitDuration.microseconds
            case .nanoseconds: return UnitDuration.nanoseconds
            case .picoseconds: return UnitDuration.picoseconds

            case  .coulombs: return UnitElectricCharge.coulombs
            case  .megaampereHours: return UnitElectricCharge.megaampereHours
            case  .kiloampereHours: return UnitElectricCharge.kiloampereHours
            case  .ampereHours: return UnitElectricCharge.ampereHours
            case  .milliampereHours: return UnitElectricCharge.milliampereHours
            case  .microampereHours: return UnitElectricCharge.microampereHours

            case .megaamperes: return UnitElectricCurrent.megaamperes
            case .kiloamperes: return UnitElectricCurrent.kiloamperes
            case .amperes: return UnitElectricCurrent.amperes
            case .milliamperes: return UnitElectricCurrent.milliamperes
            case .microamperes: return UnitElectricCurrent.microamperes

            case .megavolts: return UnitElectricPotentialDifference.megavolts
            case .kilovolts: return UnitElectricPotentialDifference.kilovolts
            case .volts: return UnitElectricPotentialDifference.volts
            case .millivolts: return UnitElectricPotentialDifference.millivolts
            case .microvolts: return UnitElectricPotentialDifference.microvolts

            case .megaohms: return UnitElectricResistance.megaohms
            case .kiloohms: return UnitElectricResistance.kiloohms
            case .ohms: return UnitElectricResistance.ohms
            case .milliohms: return UnitElectricResistance.milliohms
            case .microohms: return UnitElectricResistance.microohms

            case .kilojoules: return UnitEnergy.kilojoules
            case .joules: return UnitEnergy.joules
            case .kilocalories: return UnitEnergy.kilocalories
            case .calories: return UnitEnergy.calories
            case .kilowattHours: return UnitEnergy.kilowattHours

            case .terahertz: return UnitFrequency.terahertz
            case .gigahertz: return UnitFrequency.gigahertz
            case .megahertz: return UnitFrequency.megahertz
            case .kilohertz: return UnitFrequency.kilohertz
            case .hertz: return UnitFrequency.hertz
            case .millihertz: return UnitFrequency.millihertz
            case .microhertz: return UnitFrequency.microhertz
            case .nanohertz: return UnitFrequency.nanohertz
            case .framesPerSecond: return UnitFrequency.framesPerSecond

            case .litersPer100Kilometers: return UnitFuelEfficiency.litersPer100Kilometers
            case .milesPerImperialGallon: return UnitFuelEfficiency.milesPerImperialGallon
            case .milesPerGallon: return UnitFuelEfficiency.milesPerGallon

            case .bytes: return UnitInformationStorage.bytes
            case .bits: return UnitInformationStorage.bits
            case .nibbles: return UnitInformationStorage.nibbles
            case .yottabytes: return UnitInformationStorage.yottabytes
            case .zettabytes: return UnitInformationStorage.zettabytes
            case .exabytes: return UnitInformationStorage.exabytes
            case .petabytes: return UnitInformationStorage.petabytes
            case .terabytes: return UnitInformationStorage.terabytes
            case .gigabytes: return UnitInformationStorage.gigabytes
            case .megabytes: return UnitInformationStorage.megabytes
            case .kilobytes: return UnitInformationStorage.kilobytes
            case .yottabits: return UnitInformationStorage.yottabits
            case .zettabits: return UnitInformationStorage.zettabits
            case .exabits: return UnitInformationStorage.exabits
            case .petabits: return UnitInformationStorage.petabits
            case .terabits: return UnitInformationStorage.terabits
            case .gigabits: return UnitInformationStorage.gigabits
            case .megabits: return UnitInformationStorage.megabits
            case .kilobits: return UnitInformationStorage.kilobits
            case .yobibytes: return UnitInformationStorage.yobibytes
            case .zebibytes: return UnitInformationStorage.zebibytes
            case .exbibytes: return UnitInformationStorage.exbibytes
            case .pebibytes: return UnitInformationStorage.pebibytes
            case .tebibytes: return UnitInformationStorage.tebibytes
            case .gibibytes: return UnitInformationStorage.gibibytes
            case .mebibytes: return UnitInformationStorage.mebibytes
            case .kibibytes: return UnitInformationStorage.kibibytes
            case .yobibits: return UnitInformationStorage.yobibits
            case .zebibits: return UnitInformationStorage.zebibits
            case .exbibits: return UnitInformationStorage.exbibits
            case .pebibits: return UnitInformationStorage.pebibits
            case .tebibits: return UnitInformationStorage.tebibits
            case .gibibits: return UnitInformationStorage.gibibits
            case .mebibits: return UnitInformationStorage.mebibits
            case .kibibits: return UnitInformationStorage.kibibits

            case .megameters: return UnitLength.megameters
            case .kilometers: return UnitLength.kilometers
            case .hectometers: return UnitLength.hectometers
            case .decameters: return UnitLength.decameters
            case .meters: return UnitLength.meters
            case .decimeters: return UnitLength.decimeters
            case .centimeters: return UnitLength.centimeters
            case .millimeters: return UnitLength.millimeters
            case .micrometers: return UnitLength.micrometers
            case .nanometers: return UnitLength.nanometers
            case .picometers: return UnitLength.picometers
            case .inches: return UnitLength.inches
            case .feet: return UnitLength.feet
            case .yards: return UnitLength.yards
            case .miles: return UnitLength.miles
            case .scandinavianMiles: return UnitLength.scandinavianMiles
            case .lightyears: return UnitLength.lightyears
            case .nauticalMiles: return UnitLength.nauticalMiles
            case .fathoms: return UnitLength.fathoms
            case .furlongs: return UnitLength.furlongs
            case .astronomicalUnits: return UnitLength.astronomicalUnits
            case .parsecs: return UnitLength.parsecs

            case .lux: return UnitIlluminance.lux

            case .kilograms: return UnitMass.kilograms
            case .grams: return UnitMass.grams
            case .decigrams: return UnitMass.decigrams
            case .centigrams: return UnitMass.centigrams
            case .milligrams: return UnitMass.milligrams
            case .micrograms: return UnitMass.micrograms
            case .nanograms: return UnitMass.nanograms
            case .picograms: return UnitMass.picograms
            case .ounces: return UnitMass.ounces
            case .pounds: return UnitMass.pounds
            case .stones: return UnitMass.stones
            case .metricTons: return UnitMass.metricTons
            case .shortTons: return UnitMass.shortTons
            case .carats: return UnitMass.carats
            case .ouncesTroy: return UnitMass.ouncesTroy
            case .slugs: return UnitMass.slugs

            case .terawatts: return UnitPower.terawatts
            case .gigawatts: return UnitPower.gigawatts
            case .megawatts: return UnitPower.megawatts
            case .kilowatts: return UnitPower.kilowatts
            case .watts: return UnitPower.watts
            case .milliwatts: return UnitPower.milliwatts
            case .microwatts: return UnitPower.microwatts
            case .nanowatts: return UnitPower.nanowatts
            case .picowatts: return UnitPower.picowatts
            case .femtowatts: return UnitPower.femtowatts
            case .horsepower: return UnitPower.horsepower

            case .newtonsPerMetersSquared: return UnitPressure.newtonsPerMetersSquared
            case .gigapascals: return UnitPressure.gigapascals
            case .megapascals: return UnitPressure.megapascals
            case .kilopascals: return UnitPressure.kilopascals
            case .hectopascals: return UnitPressure.hectopascals
            case .inchesOfMercury: return UnitPressure.inchesOfMercury
            case .bars: return UnitPressure.bars
            case .millibars: return UnitPressure.millibars
            case .millimetersOfMercury: return UnitPressure.millimetersOfMercury
            case .poundsForcePerSquareInch: return UnitPressure.poundsForcePerSquareInch

            case .metersPerSecond: return UnitSpeed.metersPerSecond
            case .kilometersPerHour: return UnitSpeed.kilometersPerHour
            case .milesPerHour: return UnitSpeed.milesPerHour
            case .knots: return UnitSpeed.knots

            case .kelvin: return UnitTemperature.kelvin
            case .celsius: return UnitTemperature.celsius
            case .fahrenheit: return UnitTemperature.fahrenheit

            case .megaliters: return UnitVolume.megaliters
            case .kiloliters: return UnitVolume.kiloliters
            case .liters: return UnitVolume.liters
            case .deciliters: return UnitVolume.deciliters
            case .centiliters: return UnitVolume.centiliters
            case .milliliters: return UnitVolume.milliliters
            case .cubicKilometers: return UnitVolume.cubicKilometers
            case .cubicMeters: return UnitVolume.cubicMeters
            case .cubicDecimeters: return UnitVolume.cubicDecimeters
            case .cubicCentimeters: return UnitVolume.cubicCentimeters
            case .cubicMillimeters: return UnitVolume.cubicMillimeters
            case .cubicInches: return UnitVolume.cubicInches
            case .cubicFeet: return UnitVolume.cubicFeet
            case .cubicYards: return UnitVolume.cubicYards
            case .cubicMiles: return UnitVolume.cubicMiles
            case .acreFeet: return UnitVolume.acreFeet
            case .bushels: return UnitVolume.bushels
            case .teaspoons: return UnitVolume.teaspoons
            case .tablespoons: return UnitVolume.tablespoons
            case .fluidOunces: return UnitVolume.fluidOunces
            case .cups: return UnitVolume.cups
            case .pints: return UnitVolume.pints
            case .quarts: return UnitVolume.quarts
            case .gallons: return UnitVolume.gallons
            case .imperialTeaspoons: return UnitVolume.imperialTeaspoons
            case .imperialTablespoons: return UnitVolume.imperialTablespoons
            case .imperialFluidOunces: return UnitVolume.imperialFluidOunces
            case .imperialPints: return UnitVolume.imperialPints
            case .imperialQuarts: return UnitVolume.imperialQuarts
            case .imperialGallons: return UnitVolume.imperialGallons
            case .metricCups: return UnitVolume.metricCups
            }
        }
    }
}
