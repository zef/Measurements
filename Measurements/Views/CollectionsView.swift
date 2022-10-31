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

    @State private var navigationPath = [Collection]()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(collections) { collection in
                NavigationLink(value: collection) {
                    HStack {
                        Text(collection.displayName)
                        Spacer()
                        countImage(count: collection.itemCount)
                    }
                }
            }
            .addButton(action: newCollection, iconName: "folder.fill.badge.plus")
            .navigationTitle("Collections")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Collection.self) { collection in

                return CollectionView(collection: collection)
            }
        }
        .onAppear() {
            if let c = collections.first {
                navigationPath.append(c)
            }
        }
    }

    func countImage(count: Int) -> Image {
        if count <= 50 {
            return Image(systemName: "\(count).circle")
        } else {
            // or maybe? exclamationmark.circle.fill
            return Image(systemName: "infinity.circle")
        }
    }

    func newCollection() {
        let collection = Collection(context: viewContext)
        collection.updateTimestamps()

//        if let collection = collections.first {
//            collection.name = "Truck Bed"
//            collection.updateTimestamps()
//        }

        DataController.shared.save()
        navigationPath = [collection]
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
