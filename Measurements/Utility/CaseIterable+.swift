//
//  CaseIterable+.swift
//  Measurements
//
//  Created by Zef Houssney on 11/17/22.
//

import Foundation

extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    var nextCase: Self {
        let cases = Self.allCases
        let fallback = cases.first ?? self

        if self == cases.last {
            return fallback
        }

        guard let myIndex = cases.firstIndex(of: self) else { return fallback }
        return cases[cases.index(after: myIndex)]
    }
}
