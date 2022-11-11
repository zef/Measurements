//
//  MeasurementRowView.swift
//  Measurements
//
//  Created by Zef Houssney on 11/11/22.
//

import SwiftUI

struct MeasurementRowView: View {
    @State var measurement: Measurement

    var body: some View {
        HStack(alignment: .center) {
            if let type = measurement.unit?.unitType {
                type.icon
                    .foregroundColor(type.color)
                    .font(.system(size: 24))
                    .frame(width: 36)
            }
            VStack(alignment: .leading) {
                Text(measurement.displayValue)
                if let name = measurement.name, !name.isEmpty {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(.lightText)
                }
            }
        }
    }
}

struct MeasurementRowView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = DataController.preview.container.viewContext
        let collection = Collection.all(in: moc)[0]
        List {
            ForEach(collection.itemList[0].measurementList) { measurement in
                MeasurementRowView(measurement: measurement)
            }
        }
    }
}
