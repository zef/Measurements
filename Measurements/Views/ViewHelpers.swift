//
//  ViewHelpers.swift
//  Measurements
//
//  Created by Zef Houssney on 10/30/22.
//

import SwiftUI

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

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .bold()
            .padding(10)
            .background(Color.contrastBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
