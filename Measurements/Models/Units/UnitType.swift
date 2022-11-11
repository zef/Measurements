import Foundation
import SwiftUI

enum UnitType: String, CaseIterable, Identifiable, CustomStringConvertible {
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

    var id: Self { self }

    var description: String {
        rawValue.titleizeCamelCase
    }

    var dimensions: [Dimension.Case] {
        return Dimension.Case.allCases.filter { dimension in
            return dimension.unit.isKind(of: self.type)
        }
    }

    var type: Dimension.Type {
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
}
