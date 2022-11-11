//
//  CollectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var collection: Collection
    @State var collectionName: String
//    @FetchRequest var items: FetchedResults<Item>
//    @State var items: [Item]

    @State var editMode: Bool

    init(collection: Collection) {
        self.collection = collection
//        self.items = collection.itemList
//        _items = FetchRequest<Item>(
//            sortDescriptors: [NSSortDescriptor(keyPath: \Collection.updatedAt, ascending: true)],
//            predicate: NSPredicate(format: "collection = %@", collection)
//        )

        if let name = collection.name {
            self.collectionName = name
            self.editMode = false
        } else {
            self.collectionName = ""
            self.editMode = true
        }
    }

    var body: some View {
        collectionList
//            .listStyle(.plain)
            .sheet(isPresented: $editMode, onDismiss: updateTitle) {
                editView
            }
            .addButton(action: addItem, iconName: "plus")
            .navigationTitle(collectionName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Maybe edit the title inline?
                //
                //    ToolbarItem(placement: .principal) {
                //        TextField("Collection Name", text: $collectionName, prompt: Text("Collection Name"))
                //            .multilineTextAlignment(.center)
                //            .padding(.top, 12)
                //            .bold()
                //    }
                ToolbarItem() {
                    Button(action: editCollection) {
                        Image(systemName: "folder.fill.badge.gearshape")
                    }
                }

            }
    }

    var collectionList: some View {
        List {
            ForEach(collection.itemList) { item in
                Section(item.displayName) {
                    NavigationLink(destination: ItemView(item: item)) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(item.measurementList) { measurement in
                                MeasurementRowView(measurement: measurement)
                            }
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }

    var editView: some View {
        VStack(spacing: 20) {
            HStack  {
                Text("Edit Collection")
                    .font(.system(.headline))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Name").font(.system(.callout))
                TextField("Collection Name", text: $collectionName, prompt: Text("Collection Name"))
                    .textFieldStyle(CustomTextFieldStyle())
                    .onSubmit {
                        editMode = false
                    }
            }

            Spacer()

            Button {
                editMode = false
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }


    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            offsets.map { collection.itemList[$0] }.forEach(viewContext.delete)
            DataController.shared.save()
        }
    }

    func addItem() {
        let item = Item(context: viewContext)
        item.collection = collection
        DataController.shared.save()
    }

    func updateTitle() {
        collection.name = collectionName
        DataController.shared.save()
    }

    func editCollection() {
        editMode = true
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let moc = DataController.preview.container.viewContext
        let collection = Collection.all(in: moc)[0]
        return NavigationStack {
            CollectionView(collection: collection)
        }
    }
}
