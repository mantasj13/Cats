//
//  ServiceURLFactory.swift
//  Cats
//
//  Created by Mantas Jakstas on 30/4/24.
//

import Foundation

final class ServiceURLFactory {

    private let baseURL: URL

    init(baseURL: URL = Constants.baseURL) {
        self.baseURL = baseURL
    }

    func makeImageObjectsRandomURL() -> URL? {
        URL(string: "\(baseURL)/search?has_breeds=1?api_key=\(Constants.apiKey)")
    }

    func makeImageObjectURL(imageObjectId: String) -> URL? {
        URL(string: "\(baseURL)/\(imageObjectId)?api_key=\(Constants.apiKey)")
    }

    func makeImageObjectsURLFromBreed(breedId: String) -> URL? {
        URL(string: "\(baseURL)/search?limit=4&breed_ids=\(breedId)&api_key=\(Constants.apiKey)")
    }
}
