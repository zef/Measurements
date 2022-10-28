//
//  UnitSelectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/21/22.
//

import SwiftUI

struct UnitSelectionView: View {
    @Binding var selectedUnitType: UnitType
    @Binding var selectedUnit: Dimension

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
                    ForEach(selectedUnitType.dimensions) { unit in
                        Button {
                            if let unit = unit as? any SpecificUnit {
                                selectedUnit = unit
                            }
                        } label: {
                            Text(unit.symbol)
                                .font(.system(size: 26)).bold()
                                .selectable(selectedUnit.id == unit.symbol)
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
            selectedUnit = type.dimensions.first ?? UnitLength.inches
        } label: {
            VStack {
                Image(systemName: type.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34, height: 34)
                Text(type.description)
                    .font(.system(size: 14)).bold()
            }
            .selectable(type == selectedUnitType)
        }
    }
}

extension View {
    func selectable(_ isSelected: Bool) -> some View {
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
    @State static var selectedUnit: Dimension = UnitLength.inches

    static var previews: some View {
        UnitSelectionView(selectedUnitType: $selectedUnitType, selectedUnit: $selectedUnit)
            .padding(20)
    }
}
