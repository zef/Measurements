//
//  ItemView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/19/22.
//

import SwiftUI
import CoreData

struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var item: Item

    @State var newMeasurementValue: String = ""
    @State var newMeasurementName: String = ""

    @AppStorage(Settings.Key.lastUnitType.rawValue)
    var selectedUnitType: UnitType = .mass

    @State var selectedUnit: Dimension.Case = .defaultCase

    var body: some View {
        VStack {
            newMeasurementForm
            List {
                ForEach(item.measurementList) { measurement in
                    row(for: measurement)
                }
                .onDelete(perform: delete)
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
                    .onChange(of: item.name) { newValue in
                        DataController.shared.save()
                    }
                    // .onSubmit { }
            }

        }
    }

    func row(for measurement: Measurement) -> some View {
        VStack(alignment: .leading) {
            HStack {
                if let type = measurement.unit?.unitType {
                    type.icon
                        .foregroundColor(type.color)
//                        .symbolVariant(.fill)
                }
                Text(measurement.displayValue)
            }
            if let name = measurement.name {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.lightText)
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
        measurement.unit = selectedUnit
        measurement.item = item
        DataController.shared.save()

        newMeasurementName = ""
        newMeasurementValue = ""
    }

    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { item.measurementList[$0] }.forEach(viewContext.delete)
            DataController.shared.save()
        }
    }

}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = DataController.preview.container.viewContext
        let request: NSFetchRequest<Collection> = NSFetchRequest(entityName: "Collection")
        if let result = try? moc.fetch(request),
           let item = result.first?.itemList.first {
            ItemView(item: item)
                .environment(\.managedObjectContext, moc)
        } else {
            Text("Failed to make preview.")
        }

    }
}
