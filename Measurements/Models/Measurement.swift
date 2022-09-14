//
//  Measurement.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Measurement: Identifiable {
    var name: String?
    var value: String

    var id: UUID {
        UUID()
    }
}
