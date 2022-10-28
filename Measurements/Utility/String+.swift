//
//  String+.swift
//  Measurements
//
//  Created by Zef Houssney on 10/27/22.
//

import Foundation

extension String {
    var titleizeCamelCase: String {
        self.replacing(/([A-Z])/) { " \($0.1)" }.capitalized
    }
}
