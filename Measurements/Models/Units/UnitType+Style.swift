//
//  UnitType+Style.swift
//  Measurements
//
//  Created by Zef Houssney on 11/10/22.
//

import Foundation
import SwiftUI

extension UnitType {

    var icon: Image {
        Image(systemName: iconName)
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
        case .length: return "ruler"
        case .mass: return "scalemass"
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
