//
//  ObjectView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/19/22.
//

import SwiftUI

struct ObjectView: View {
    var object: Object

    @State var newDimensionValue: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("New Dimension", text: $newDimensionValue)
                Spacer()
                Image(systemName: "plus.circle")
                    .foregroundColor(.blue)
                    .font(.system(size: 24))
            }
            .padding(20)

            List(object.measurements) { measurement in
                HStack {
                    Text(measurement.displayValue)
                    Spacer()
                    if let name = measurement.name {
                        Text(name)
                    }
                }
            }
        }
//            .foregroundColor(.gray)
    }
}

struct ObjectView_Previews: PreviewProvider {
    static var previews: some View {
        if let object = Collection.kitchen.objects.first {
            ObjectView(object: object)
        }
    }
}
