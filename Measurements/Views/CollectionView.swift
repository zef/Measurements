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
        self.items = collection.itemList

        if collectionName == "" {
            editMode = true
        }
    }

    @ObservedObject var collection: Collection
    @State var collectionName: String
    @State var items: [Item]

    @State var editMode = false

    var body: some View {
        collectionList
            .listStyle(.plain)
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
            .onDelete(perform: deleteItems)
        }
        .onAppear {
            print("List did appear")
//            self.items = collection.itemList
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
        return NavigationStack {
//            CollectionView(collection: collection)
        }
    }
}
