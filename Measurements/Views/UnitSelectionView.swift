//
//  UnitSelectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/21/22.
//

import SwiftUI

struct UnitSelectionView: View {
    @Binding var selectedUnitType: UnitType
    @Binding var selectedUnit: Dimension.Case


    func filteredDimensions(for type: UnitType) -> [Dimension.Case] {
        var dimensions = type.dimensions
        return dimensions
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(UnitType.allCases) { type in
                        typeButton(type: type)
                    }
                }
            }
            Divider()
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 4) {
                    ForEach(filteredDimensions(for: selectedUnitType)) { dimension in
                        Button {
                            selectedUnit = dimension
                        } label: {
                            VStack {
                                Text(dimension.unit.symbol)
                                    .font(.system(size: 26)).bold()
                                Text(dimension.description)
                                    .font(.system(size: 14)).bold()
                            }
                            .selectable(isSelected: selectedUnit == dimension)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .stroke(Color.metric, lineWidth: 4)
////                                        .stroke(unit.isMetric ? Color.metric : Color.sae, lineWidth: 4)
//                                }
//                                .padding(4)
                        }
                    }
                }
            }
        }
    }

    func typeButton(type: UnitType) -> some View {
        Button {
            selectedUnitType = type
            selectedUnit = type.dimensions.first ?? .defaultCase
        } label: {
            VStack {
                Image(systemName: type.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34, height: 34)
                Text(type.description)
                    .font(.system(size: 14)).bold()
            }
//            .symbolVariant(.fill)
            .selectable(isSelected: type == selectedUnitType)
        }
    }
}

extension View {
    func selectable(isSelected: Bool) -> some View {
        return self
            .padding(.vertical, 16)
            .padding(.horizontal, 22)
            .foregroundColor(isSelected ? .accentColor : Color.text)
            .background(isSelected ? Color.accentColor.opacity(0.24) : .clear)
            .cornerRadius(22)
    }
}


struct UnitSelectionView_Previews: PreviewProvider {
    @State static var selectedUnitType: UnitType = .mass
    @State static var selectedUnit: Dimension.Case = .defaultCase

    static var previews: some View {
        UnitSelectionView(selectedUnitType: $selectedUnitType, selectedUnit: $selectedUnit)
            .padding(20)
    }
}
