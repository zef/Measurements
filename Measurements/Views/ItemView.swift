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
    @State var editingMeasurement: Measurement?

    var body: some View {
        list
            .overlay(alignment: .bottom) {
                if editingMeasurement.isSet {
                    VStack {
                        Text(editingMeasurement.unsafelyUnwrapped.displayName)
                        MeasurementForm(measurement: editingMeasurement.unsafelyUnwrapped,binding: $editingMeasurement)?.onAppear() {
                            print("new form made")
                        }
                    }
                }
            }
        
            .navigationTitle(item.displayName)
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
                ToolbarItem {
                    Button {
                        print("delete")
                    } label: {
                        Icon.delete.image
                    }

                }
            }
    }

    var list: some View {
            List {
                Section {
                    ForEach(item.measurementList) { measurement in
                        Button {
                            print("changing measurement")
                            self.editingMeasurement = measurement
                        } label: {
                            MeasurementRowView(measurement: measurement)
                        }

                    }
                    .onDelete(perform: delete)
                } footer: {
                    VStack {
                        Button("New Measurement") {
                            let measurement = Measurement(context: viewContext)
                            measurement.item = item
                            self.editingMeasurement = measurement
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)

                        NavigationLink("Test Round") {
                            RoundSelectorView()
                        }
                        .padding(10)
                        NavigationLink("Test Fractions") {
                            FractionSelectionView()
                        }
                        .padding(10)

                        if let updatedAt = item.updatedAt {
                            Text("Updated on \(updatedAt.formatted(date: .numeric, time: .shortened))")
                                .font(.caption)
                        }
                        if let createdAt = item.createdAt {
                            Text("Created on \(createdAt.formatted(date: .numeric, time: .shortened))")
                                .font(.caption)
                        }
                    }
                }
            }
    }

    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { item.measurementList[$0] }.forEach(viewContext.delete)
            DataController.shared.save()
        }
    }
}

struct MeasurementForm: View {
    enum Field: Hashable, CaseIterable {
        case name
        case value
    }

    init?(measurement: Measurement, binding: Binding<Measurement?>) {
        self.measurementBinding = binding

//        guard let measurement = binding.wrappedValue else { return nil }
        self.measurement = measurement

        self.newName = measurement.name ?? ""
        self.newValue = measurement.value.formatted(.number)
        print("setting up for", measurement.name ?? "NONE")

        self.selectedUnit = measurement.unit ?? .defaultCase
        self.selectedUnitType = selectedUnit.unitType
    }

    var measurementBinding: Binding<Measurement?>

    @ObservedObject var measurement: Measurement

    @State var newName: String
    @State var newValue: String

    @AppStorage(Settings.Key.lastUnitType.rawValue)
    var selectedUnitType: UnitType = .length
    @State var selectedUnit: Dimension.Case

    @FocusState private var focusedField: Field?

//    var isInserted: String {
//        if let v = measurementBinding.wrappedValue {
//            return v.isUpdated ? "YES" : "NO"
//        } else {
//            return "NONE"
//        }
//    }

    var body: some View {
        VStack(spacing: 10) {
//            Text("form ID: \(String)")
            Text("Name value: \(newName)")
            TextField("Measurement Name", text: $newName, prompt: Text("Measurement Name"))
                .autocapitalization(.none)
                .focused($focusedField, equals: .name)
                .onSubmit {
                    focusedField = .value
                }
            HStack {
                TextField("Measurement Value", text: $newValue, prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .value)
                    .onSubmit {
                        saveMeasurement()
                    }
                Spacer()
                Button {
                    saveMeasurement()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 28))
                }
            }
            UnitSelectionView(selectedUnitType: $selectedUnitType, selectedUnit: $selectedUnit)
        }
        .padding(10)
        .background(Color.background)
        .textFieldStyle(CustomTextFieldStyle())
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
                } label: {
                    Icon.keyboardDown.image
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = focusedField?.nextCase
                } label: {
                    if focusedField == .value {
                        Text("Save")
                    } else {
                        Text("Next")
                    }
                }
            }
        }
    }

    func saveMeasurement() {
        guard let value = Double(newValue) else {
            print("could not create measurement, value is not a Double")
            return
        }
        guard let measurement = measurementBinding.wrappedValue else { return }

        measurement.name = newName
        measurement.value = value
        measurement.unit = selectedUnit
        DataController.shared.save()

        newName = ""
        newValue = ""
        measurementBinding.wrappedValue = nil
    }

}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = DataController.preview.container.viewContext
        let collections = Collection.all(in: moc)
        if let item = collections.first?.itemList.first {
            ItemView(item: item)
                .environment(\.managedObjectContext, moc)
        } else {
            Text("Failed to make preview.")
        }
    }
}
