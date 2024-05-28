//
//  ButtonStyle.swift
//  Cats
//
//  Created by Mantas Jakstas on 28/5/24.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding(18)
            .background(
                Color.blue
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
            )
    }
}
