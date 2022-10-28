//
//  Dimension.swift
//  Measurements
//
//  Created by Zef Houssney on 10/27/22.
//

import Foundation


extension Dimension {
    var unitType: any SpecificUnit.Type {
        switch self {
        case is UnitAcceleration: return UnitAcceleration.self
        case is UnitAngle: return UnitAngle.self
        case is UnitArea: return UnitArea.self
        case is UnitConcentrationMass: return UnitConcentrationMass.self
        case is UnitDispersion: return UnitDispersion.self
        case is UnitDuration: return UnitDuration.self
        case is UnitElectricCharge: return UnitElectricCharge.self
        case is UnitElectricCurrent: return UnitElectricCurrent.self
        case is UnitElectricPotentialDifference: return UnitElectricPotentialDifference.self
        case is UnitElectricResistance: return UnitElectricResistance.self
        case is UnitEnergy: return UnitEnergy.self
        case is UnitFrequency: return UnitFrequency.self
        case is UnitFuelEfficiency: return UnitFuelEfficiency.self
        case is UnitIlluminance: return UnitIlluminance.self
        case is UnitInformationStorage: return UnitInformationStorage.self
        case is UnitLength: return UnitLength.self
        case is UnitMass: return UnitMass.self
        case is UnitPower: return UnitPower.self
        case is UnitPressure: return UnitPressure.self
        case is UnitSpeed: return UnitSpeed.self
        case is UnitTemperature: return UnitTemperature.self
        case is UnitVolume: return UnitVolume.self
        default:
            assertionFailure("All Dimensions should return a SpecificUnit.")
            return UnitLength.self
        }
    }

    var unitTypeName: String {
        unitType.description().replacing("NSUnit", with: "").replacing(/^[A-Z]{1}/) { $0.0.lowercased() }
    }
}
