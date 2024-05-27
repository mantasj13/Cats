//
//  CatsService.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

enum CatsServiceError: Error {
    case noObjects
}

protocol CatsServiceProtocol {
    func fetchRandomImageObject() async throws -> ImageObject
    func fetchImageObjectFromImageObjectId(_ imageObjectId: String) async throws -> ImageObject
    func fetchImageObjectsFromBreedId(_ breedId: String) async throws -> [ImageObject]
}

final class CatsService: CatsServiceProtocol {

    private let api: APIProtocol
    private let urlFactory: ServiceURLFactory

    init(
        api: APIProtocol = API(),
        service: ServiceURLFactory = ServiceURLFactory()
    ) {
        self.api = api
        self.urlFactory = service
    }

    func fetchRandomImageObject() async throws -> ImageObject {
        guard let imageObjectURL = urlFactory.makeImageObjectsRandomURL() else {
            throw NetworkingError.invalidURL
        }

        let imageObjects: [ImageObject] = try await api.fetch(url: imageObjectURL)

        if let imageObject = imageObjects.first {
            return imageObject
        } else {
            throw CatsServiceError.noObjects
        }
    }

    func fetchImageObjectFromImageObjectId(_ id: String) async throws -> ImageObject {
        guard let imageObjectURL = urlFactory.makeImageObjectURL(imageObjectId: id) else {
            throw NetworkingError.invalidURL
        }

        return try await api.fetch(url: imageObjectURL)
    }

    func fetchImageObjectsFromBreedId(_ breedId: String) async throws -> [ImageObject] {
        guard let imageObjectsURL = urlFactory.makeImageObjectsURLFromBreed(breedId: breedId) else {
            throw NetworkingError.invalidURL
        }

        return try await api.fetch(url: imageObjectsURL)
    }
}

