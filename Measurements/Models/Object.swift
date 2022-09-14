//
//  Object.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Object: Identifiable {
    var name: String
    var measurements = [Measurement]()

    var id: String {
        name
    }
}

