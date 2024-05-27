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
            .foregroundColor(.primary)
            .font(.system(size: 16))
            .frame(width: 220, height: 50)
            .background(.blue)
            .cornerRadius(15)
        }
        .padding(.vertical, 15)
    }
}
