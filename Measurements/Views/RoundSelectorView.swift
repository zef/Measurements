//
//  RoundSelectorView.swift
//  Measurements
//
//  Created by Zef Houssney on 11/17/22.
//

import SwiftUI

extension Angle {
    static func divisions(divisionCount: Int) -> [Angle] {
        let perDivision = 360/Double(divisionCount)
        return Array(0..<divisionCount).map { index in
            let degrees = Double(index) * perDivision
            return Angle(degrees: degrees)
        }
    }
}


struct RoundSelectorView: View {

    typealias ButtonConfig = (angle: Angle, item: UnitType)

    var buttons: [ButtonConfig] = {
        Angle.divisions(divisionCount: 10).enumerated().compactMap { index, angle in
            return (angle, UnitType.allCases[index])
        }
    }()

    var body: some View {
        ZStack {
            ForEach(buttons, id: \.item) { config in
                button(config: config)
                    .padding(.bottom, 180)
                    .rotationEffect(config.angle)
            }
        }
    }

    func button(config: ButtonConfig) -> some View {
        Button {
//            selectedUnitType = type
//            selectedUnit = type.dimensions.first ?? .defaultCase
        } label: {
            VStack(spacing: 2) {
                Image(systemName: config.item.iconName)
                    .resizable()
//                    .symbolVariant(.circle)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(8)
//                    .background(Circle().foregroundColor(Color.accentColor.opacity(0.24)))
                Text(config.item.description)
                    .font(.system(size: 12)).bold()
            }
//            .symbolVariant(.fill)
//            .selectable(isSelected: type == selectedUnitType)
        }
        .rotationEffect(-config.angle)
    }

}

struct RoundSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        RoundSelectorView()
    }
}
