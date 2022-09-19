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
                Text(object.name)
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: Collection.kitchen)
    }
}
