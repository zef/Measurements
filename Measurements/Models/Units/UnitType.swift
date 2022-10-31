import Foundation
import SwiftUI

enum UnitType: String, CaseIterable, Identifiable {
    case length
    case mass
    case volume
    case speed
    case temperature
    case angle
    case duration
    case area
    case acceleration
    case fuelEfficiency
    case electricCharge
    case electricCurrent
    case electricPotentialDifference
    case electricResistance
    case energy
    case power
    case frequency
    case pressure
    case dispersion
    case illuminance
    case informationStorage
    case concentrationMass

    var id: String { rawValue }

    var description: String {
        rawValue.titleizeCamelCase
    }

    var dimensions: [Dimension] {
        type.dimensions
    }

//    init(unit: Dimension) {
//
//    }

    var type: any SpecificUnit.Type {
        switch self {
        case .acceleration: return UnitAcceleration.self
        case .angle: return UnitAngle.self
        case .area: return UnitArea.self
        case .concentrationMass: return UnitConcentrationMass.self
        case .dispersion: return UnitDispersion.self
        case .duration: return UnitDuration.self
        case .electricCharge: return UnitElectricCharge.self
        case .electricCurrent: return UnitElectricCurrent.self
        case .electricPotentialDifference: return UnitElectricPotentialDifference.self
        case .electricResistance: return UnitElectricResistance.self
        case .energy: return UnitEnergy.self
        case .frequency: return UnitFrequency.self
        case .fuelEfficiency: return UnitFuelEfficiency.self
        case .illuminance: return UnitIlluminance.self
        case .informationStorage: return UnitInformationStorage.self
        case .length: return UnitLength.self
        case .mass: return UnitMass.self
        case .power: return UnitPower.self
        case .pressure: return UnitPressure.self
        case .speed: return UnitSpeed.self
        case .temperature: return UnitTemperature.self
        case .volume: return UnitVolume.self
        }
    }

    var iconName: String {
        switch self {
        case .acceleration: return "hare" // TODO: Better
        case .angle: return "angle"
        case .area: return "square.dotted" // TODO: Better
        case .concentrationMass: return "wineglass" // TODO: Better
        case .dispersion: return "aqi.medium"
        case .duration: return "clock"
        case .electricCharge: return "bolt.ring.closed" // TODO: Better
        case .electricCurrent: return "amplifier"
        case .electricPotentialDifference: return "bolt" // TODO: Better
        case .electricResistance: return "bolt.circle" // TODO: Better
        case .energy: return "bolt.square" // TODO: Better
        case .frequency: return "waveform.path"
        case .fuelEfficiency: return "car"
        case .illuminance: return "lightbulb"
        case .informationStorage: return "externaldrive"
        case .length: return "ruler.fill"
        case .mass: return "scalemass.fill"
        case .power: return "power"
        case .pressure: return "rectangle.compress.vertical"
        case .speed: return "speedometer"
        case .temperature: return "thermometer.medium"
        case .volume: return "shippingbox"
        }
    }

    var color: Color {
        switch self {
        case .acceleration: return .purple
        case .angle: return .gray
        case .area: return .gray
        case .concentrationMass: return .gray
        case .dispersion: return .gray
        case .duration: return .gray
        case .electricCharge: return .orange
        case .electricCurrent: return .orange
        case .electricPotentialDifference: return .orange
        case .electricResistance: return .orange
        case .energy: return .orange
        case .frequency: return .gray
        case .fuelEfficiency: return .gray
        case .illuminance: return .gray
        case .informationStorage: return .gray
        case .length: return .yellow
        case .mass: return .blue
        case .power: return .gray
        case .pressure: return .gray
        case .speed: return .purple
        case .temperature: return .red
        case .volume: return .green
        }
    }
}
