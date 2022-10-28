//
//  ObjectView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/19/22.
//

import SwiftUI

struct ObjectView: View {
    @ObservedObject var object: Object
    @State var newDimensionValue: String = ""

    @AppStorage(Settings.Key.lastUnitType.rawValue)
    var selectedUnitType: UnitType = .mass
    @State var selectedUnit: Dimension = UnitLength.inches

    var body: some View {
        VStack {
            HStack {
                TextField("New Dimension", text: $newDimensionValue)
                    .keyboardType(.decimalPad)
                Spacer()
                Button {
                    createNewMeasurement()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 28))
                }
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
            UnitSelectionView(selectedUnitType: $selectedUnitType, selectedUnit: $selectedUnit)
                .padding(8)
        }
//            .foregroundColor(.gray)
        .navigationTitle(object.name)
    }

    func createNewMeasurement() {
        guard let value = Double(newDimensionValue) else {
            print("could not create measurement, value is not a Double")
            return
        }
        let measurement = Measurement(value: value)
        object.measurements.append(measurement)

    }
}

struct ObjectView_Previews: PreviewProvider {
    static var previews: some View {
        if let object = Collection.kitchen.objects.first {
            ObjectView(object: object)
        }
    }
}
