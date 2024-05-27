//
//  BreedCardImage.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct BreedCardImage: View {

    let imageURL: URL

    var body: some View {
        VStack {
            AsyncImage(
                url: imageURL,
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(.scale(scale: 0.3, anchor: .center))
                case .failure:
                    Image(systemName: "wifi.slash")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 160, height: 190, alignment: .top)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}


