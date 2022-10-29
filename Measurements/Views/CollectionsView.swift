//
//  CollectionsView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionsView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Collection.updatedAt, ascending: true)],
        animation: .default)
    private var collections: FetchedResults<Collection>

//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.updatedAt, ascending: true)], predicate: )
//    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List(collections) { collection in
                NavigationLink(destination: CollectionView(collection: collection)) {
                    Text(collection.displayName)
                }
            }
            .addButton(action: newCollection, iconName: "folder.fill.badge.plus")
            .navigationTitle("Collections")
        }
    }

    func newCollection() {
        let collection = Collection(context: viewContext)
        collection.updateTimestamps()
        collection.name = Date().formatted(date: .long, time: .shortened)

        PersistenceController.shared.save()
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
