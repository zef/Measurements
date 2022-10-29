//
//  ItemView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/19/22.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var item: Item
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

            List(item.measurementList) { measurement in
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
        .navigationTitle(item.displayName)
    }

    func createNewMeasurement() {
        guard let value = Double(newDimensionValue) else {
            print("could not create measurement, value is not a Double")
            return
        }
        print(value)
//        let measurement = Measurement(value: value)
//        item.measurements.append(measurement)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        Text("todo")
//        if let object = Collection.kitchen.objects.first {
//            ItemView(object: object)
//        }
    }
}
