//
//  CollectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

struct CollectionView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var collection: Collection

    var body: some View {
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
        .addButton(action: newItem, iconName: "plus")
        .navigationTitle(collection.displayName)
        .navigationBarTitleDisplayMode(.inline)
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
}

extension View {
    @ViewBuilder public func addButton(action: @escaping () -> Void, iconName: String) -> some View {
        self.overlay(alignment: .bottomTrailing) {
            Button(action: action) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 34, height: 34)
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.orange, lineWidth: 4)
            }
            .padding(20)
        }
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
//        let collection = Collection()
        
        return CollectionView(collection: collection)
    }
}
