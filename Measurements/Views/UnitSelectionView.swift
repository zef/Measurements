//
//  UnitSelectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 9/21/22.
//

import SwiftUI

struct UnitSelectionView: View {
    var body: some View {
        HStack(spacing: 28) {
            ForEach(Measurement.UnitType.allCases) { type in
                VStack {
                    Label(type.name, systemImage: type.iconName())
                        .labelStyle(VerticalLabelStyle())
                }
            }
        }
    }
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack() {
            configuration.icon
                .aspectRatio(contentMode: .fill)
                .font(.system(size: 50))
                .frame(width: 60, height: 60)

            configuration.title
        }
    }
}


struct UnitSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UnitSelectionView()
    }
}
