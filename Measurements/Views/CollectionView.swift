//
//  CollectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionView: View {
    @Environment(\.managedObjectContext) private var viewContext

    init(collection: Collection) {
        self.collection = collection
        self.collectionName = collection.name ?? ""
    }

    @State var collection: Collection
    @State var collectionName: String

    @State var editMode = false

    var body: some View {
        collectionList
            .listStyle(.plain)
            .sheet(isPresented: $editMode, onDismiss: updateTitle) {
                editView
            }
            .addButton(action: newItem, iconName: "plus")
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

    var editView: some View {
        VStack(spacing: 20) {
            HStack  {
                Text("Edit Collection")
                    .font(.system(.headline))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Name")
                    .font(.system(.callout))
                TextField("Collection Name", text: $collectionName, prompt: Text("Collection Name"))
                    .bold()
                    .padding(10)
                    .background(Color.contrastBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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

    var collectionList: some View {
        List(collection.itemList) { item in
            Section(item.displayName) {
                NavigationLink(destination: ItemView(item: item)) {
                    VStack(spacing: 10) {
                        ForEach(item.measurementList) { measurement in
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
    }


    func newItem() {
        let item = Item(context: viewContext)
        collection.addToItems(item)
        item.collection = collection
        item.updateTimestamps()
        item.name = Date().formatted(date: .long, time: .shortened)
//        print("Collection items: \(collection.itemList)")
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
        let preview = DataController.preview

        let collection = Collection(context: preview.container.viewContext)
        collection.name = "House Stuff"

        let item = Item(context: preview.container.viewContext)
        item.name = "Door"
//        item.value = 28

        preview.save()

        return NavigationStack {
            CollectionView(collection: collection)
        }
    }
}
