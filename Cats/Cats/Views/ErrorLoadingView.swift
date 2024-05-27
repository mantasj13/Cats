//
//  ErrorLoadingView.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct ErrorLoadingView: View {

    let errorMessage: String
    let action: () -> Void

    var body: some View {
        ZStack {
            Color.white
            VStack(alignment: .center, spacing: 12) {
                Text(errorMessage)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)

                Image(systemName: "text.badge.xmark")
                    .font(.system(size: 50.0))
                    .foregroundColor(.gray)

                Button("Retry", action: action)
                .font(.subheadline)
                .padding(.top, 15)
            }
        }
        .ignoresSafeArea()
    }
}
