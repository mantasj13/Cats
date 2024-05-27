//
//  CardView.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct CardView: View {

    let cat: ImageObject
    let imageURL: URL
    let targetSize: CGSize

    var body: some View {
        let aspectRatio = CGFloat(cat.width) / CGFloat(cat.height)
        let scaledHeight = targetSize.width / aspectRatio

        VStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                        .resizable()
                        .frame(width: 120, height: 120)

                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(width: targetSize.width, height: scaledHeight, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .shadow, radius: 15)
    }
}
