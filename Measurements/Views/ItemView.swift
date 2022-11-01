//
//  ItemView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/19/22.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var item: Item

    @State var newMeasurementValue: String = ""
    @State var newMeasurementName: String = ""

    @AppStorage(Settings.Key.lastUnitType.rawValue)
    var selectedUnitType: UnitType = .mass
    @State var selectedUnit: Dimension = UnitLength.inches


    var body: some View {
        VStack {
            newMeasurementForm
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
        }
        .navigationTitle(item.displayName)
        .padding(8)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("Item Name", text: Binding($item.name, ""), prompt: Text("Item Name"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                // centering the text in the field
                // Would like a better way of doing this.
                    .padding(.trailing, 35)
                    .bold()
            }

        }
    }

    var newMeasurementForm: some View {
        VStack(spacing: 10) {
            TextField("Measurement Name", text: $newMeasurementName, prompt: Text("Measurement Name"))
            HStack {
                TextField("Measurement Value", text: $newMeasurementValue, prompt: Text("0.0"))
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
        }
        .textFieldStyle(CustomTextFieldStyle())
        .padding(20)
    }

    func createNewMeasurement() {
        guard let value = Double(newMeasurementValue) else {
            print("could not create measurement, value is not a Double")
            return
        }
        print(value)

        let measurement = Measurement(context: viewContext)
        measurement.name = newMeasurementName
        measurement.value = value
        measurement.unit = selectedUnit.displayName
        measurement.item = item
        DataController.shared.save()

        newMeasurementName = ""
        newMeasurementValue = ""
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
