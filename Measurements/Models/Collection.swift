//
//  Collection.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import Foundation

struct Collection: Identifiable {
    var name: String
    var objects = [Object]()

    var id: String {
        name
    }
}

extension Collection {
    static var kitchen: Collection {
        var kitchen = Collection(name: "Kitchen")
        kitchen.objects = [
            Object(name: "Sink"),
            Object(name: "Island")
        ]
        return kitchen
    }
    static var sampleList: [Collection] {
        return [
            kitchen,
            Collection(name: "Part")
        ]
    }
}
