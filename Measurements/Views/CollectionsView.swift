//
//  CollectionsView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionsView: View {

    var collections = Collection.sampleList

    var body: some View {
        NavigationView {
            List(collections) { collection in
                NavigationLink(destination: CollectionView(collection: collection)) {
                    Text(collection.name)
                }
            }
            .navigationTitle("Collections")
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
