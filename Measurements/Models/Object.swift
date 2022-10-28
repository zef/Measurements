//
//  Object.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

class Object: Identifiable, ObservableObject {
    @Published var name: String
    @Published var measurements = [Measurement]()

    init(name: String, measurements: [Measurement] = [Measurement]()) {
        self.name = name
        self.measurements = measurements
    }

    var id: String {
        name
    }
}

