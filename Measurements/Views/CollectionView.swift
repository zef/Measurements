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
        List(collection.objects) { object in
            Section(object.name) {
                NavigationLink(destination: ObjectView(object: object)) {
                    VStack(spacing: 10) {
                        ForEach(object.measurements) { measurement in
                            HStack {
                                Text(measurement.displayValue)
                                Spacer()
                                if let name = measurement.name {
                                    Text(name)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(collection.name)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: Collection.kitchen)
    }
}
