//
//  ImageObject.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

struct ImageObject: Decodable, Identifiable {
    let id: String
    let url: URL
    let breeds: [Breed]?
    let width: Int
    let height: Int
}

struct Breed: Decodable, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let description: String
}
