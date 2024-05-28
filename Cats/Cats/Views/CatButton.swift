//
//  FetchBreedImagesButton.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct CatButton: View {
    let title: String
    let action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: "arrow.circlepath")
                Text(title)
            }
        }
        .buttonStyle(RoundedButtonStyle())
        .padding(.vertical, 15)
    }
}
