//
//  Settings.swift
//  Measurements
//
//  Created by Zef Houssney on 9/21/22.
//

import Foundation

struct Settings {
    enum Key: String {
        case lastUnitType
    }

    static var includeImperialUnits: Bool {
        false
    }

    static var usOnly: Bool {
        false
    }
}
