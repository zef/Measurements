//
//  CollectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionView: View {
    var collection: Collection

    var body: some View {
        VStack {
            Text(collection.name)
                .font(.largeTitle)

            List(collection.objects) { object in
                Section(object.name) {
                    ForEach(object.measurements) { measurement in
                        HStack {
                            Text(measurement.value)
                            Spacer()
                            if let name = measurement.name {
                                Text(name)
                                    .foregroundColor(.gray)
                            }
                        }
                    }

                    HStack {
                        Text("New Dimension")
                        Spacer()
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                    }
                    .foregroundColor(.gray)
                }
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: Collection.kitchen)
    }
}
