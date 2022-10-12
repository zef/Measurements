//
//  UnitSelectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/21/22.
//

import SwiftUI

struct UnitSelectionView: View {
    @AppStorage(Settings.Key.lastUnitType.rawValue) var selectedUnitType: Measurement.UnitType = .mass

    @State var selectedUnit = "in"
//    var selectedUnitType: Measurement.UnitType {
//        Settings.lastUnitType
//    }

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(Measurement.UnitType.allCases) { type in
                        typeButton(type: type)
                    }
                }
            }
            Divider()
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 4) {
                    ForEach(selectedUnitType.dimensions) { unit in
                        Button {
                            selectedUnit = unit.symbol
                        } label: {
                            Text(unit.symbol)
                                .font(.system(size: 26)).bold()
                                .selectable(selectedUnit == unit.symbol)
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

    func typeButton(type: Measurement.UnitType) -> some View {
        Button {
            selectedUnitType = type
            selectedUnit = type.dimensions.first?.symbol ?? ""
        } label: {
            VStack {
                Image(systemName: type.iconName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text(type.name)
                    .font(.system(size: 18)).bold()
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
    static var previews: some View {
        UnitSelectionView()
            .padding(20)
    }
}
