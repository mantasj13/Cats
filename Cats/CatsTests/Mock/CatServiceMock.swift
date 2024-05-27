//
//  CatServiceMock.swift
//  CatsTests
//
//  Created by Mantas Jakstas on 5/5/24.
//

import Foundation
import XCTest
@testable import Cats

final class CatServiceMock: CatsServiceProtocol {

    var fetchRandomImageObjectResult: Result<ImageObject, Error>?
    var fetchImageObjectFromImageObjectIdResult: Result<ImageObject, Error>?
    var fetchImageObjectsFromBreedIdResult: Result<[ImageObject], Error>?

    init(fetchRandomImageObjectResult: Result<ImageObject, Error>? = nil, fetchImageObjectFromImageObjectIdResult: Result<ImageObject, Error>? = nil, fetchImageObjectsFromBreedIdResult: Result<[ImageObject], Error>? = nil
    ) {
        self.fetchRandomImageObjectResult = fetchRandomImageObjectResult
        self.fetchImageObjectFromImageObjectIdResult = fetchImageObjectFromImageObjectIdResult
        self.fetchImageObjectsFromBreedIdResult = fetchImageObjectsFromBreedIdResult
    }

    func fetchRandomImageObject() async throws -> ImageObject {
        switch fetchRandomImageObjectResult {
        case .success(let imageObject):
            return imageObject
        case .failure(let error):
            throw error
        case .none:
            fatalError()
        }
    }

    func fetchImageObjectFromImageObjectId(_ imageObjectId: String) async throws -> ImageObject {
        switch fetchImageObjectFromImageObjectIdResult {
        case .success(let imageObject):
            return imageObject
        case .failure(let error):
            throw error
        case .none:
            fatalError()
        }
    }

    func fetchImageObjectsFromBreedId(_ breedId: String) async throws -> [ImageObject] {
        switch fetchImageObjectsFromBreedIdResult {
        case .success(let imageObjects):
            return imageObjects
        case .failure(let error):
            throw error
        case .none:
            fatalError()
        }
    }
}
