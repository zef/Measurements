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

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(collections) { collection in
                    NavigationLink(value: collection) {
                        HStack {
                            Text(collection.displayName)
                            Spacer()
                            countImage(count: collection.itemCount)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .addButton(action: newCollection, iconName: "folder.fill.badge.plus")
            .navigationTitle("Collections")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Collection.self) { collection in

                return CollectionView(collection: collection)
            }
        }
        .onAppear() {
            if let collection = collections.first {
                path.append(collection)
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
//            collection.name = "House"
//            collection.updateTimestamps()
//        }

        DataController.shared.save()
        path.append(collection)
    }

    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            offsets.map { collections[$0] }.forEach(viewContext.delete)
            DataController.shared.save()
        }
    }
}

struct CollectionsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsView()
    }
}
