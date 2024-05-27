//
//  InfoView.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct InfoView: View {

    let breed: Breed

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
            Text(breed.name)
                .font(.title)
            HStack {
                Text("Description")
                    .font(.title3)
                Image(systemName: "square.text.square")
            }
            .foregroundColor(.blue)
            
            Text(breed.description)
                .font(.callout)

            HStack {
                Text("Temperament")
                    .font(.title3)
                Image(systemName: "cat")
            }
            .foregroundColor(.blue)

            Text(breed.temperament)
                .font(.callout)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
