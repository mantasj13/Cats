//
//  DetailsCatViewTests.swift
//  CatsTests
//
//  Created by Mantas Jakstas on 3/5/24.
//

import XCTest
@testable import Cats


final class CatDetailsViewModelTests: XCTestCase {

    private var sut: CatDetailsViewModel!
    private var catServiceMock: CatServiceMock!

    @MainActor
    override func setUp() {
        super.setUp()
        catServiceMock = CatServiceMock()
        sut = CatDetailsViewModel(
            imageObjectId: "A5JigBZjG",
            catService: catServiceMock
        )
    }

    override func tearDown() {
        catServiceMock = nil
        sut = nil
        super.tearDown()
    }

    @MainActor
    func testFetchData_SuccessBothNetworkRequest() async {
        // Given
        catServiceMock.fetchRandomImageObjectResult = .success(
            ImageObject(
                id: "not used",
                url: URL(string: "www.google.com")!,
                breeds: nil,
                width: 20,
                height: 20
            )
        )

        let breeds = [
            Breed(id: "crex", name: "Cornish Rex", temperament: "Affectionate, Intelligent, Active, Curious, Playful", description: "This is a confident cat who loves people and will follow them around, waiting for any opportunity to sit in a lap or give a kiss. He enjoys being handled, making it easy to take him to the veterinarian or train him for therapy work. The Cornish Rex stay in kitten mode most of their lives and well into their senior years. ")
        ]
        catServiceMock.fetchImageObjectFromImageObjectIdResult = .success(
            ImageObject(
                id: "A5JigBZjG",
                url: URL(string: "https://cdn2.thecatapi.com/images/A5JigBZjG.jpg")!,
                breeds: breeds,
                width: 254,
                height: 254
            )
        )

        let breed = Breed(id: "crex", name: "Cornish Rex", temperament: "Affectionate, Intelligent, Active, Curious, Playful", description: "This is a confident cat who loves people and will follow them around, waiting for any opportunity to sit in a lap or give a kiss. He enjoys being handled, making it easy to take him to the veterinarian or train him for therapy work. The Cornish Rex stay in kitten mode most of their lives and well into their senior years. ")
        catServiceMock.fetchImageObjectsFromBreedIdResult = .success(
            [
                ImageObject(
                    id: "8CuEPFNuD",
                    url: URL(string: "https://cdn2.thecatapi.com/images/8CuEPFNuD.jpg")!,
                    breeds: [breed],
                    width: 1024,
                    height: 768
                ),
                ImageObject(
                    id: "bAiN3T-rs",
                    url: URL(string: "https://cdn2.thecatapi.com/images/bAiN3T-rs.jpg")!,
                    breeds: [breed],
                    width: 1024,
                    height: 788
                ),
                ImageObject(
                    id: "RIRLq-8sp",
                    url: URL(string: "https://cdn2.thecatapi.com/images/RIRLq-8sp.jpg")!,
                    breeds: [breed],
                    width: 1250,
                    height: 702
                ),
                ImageObject(
                    id: "yqcbOxkWK",
                    url: URL(string: "https://cdn2.thecatapi.com/images/yqcbOxkWK.jpg")!,
                    breeds: [breed],
                    width: 970,
                    height: 500
                )
            ]
        )

        // When
        await sut.fetchData()

        // Then
        switch sut.state {
        case .breedLoaded(let breed, _):
            XCTAssertEqual(breed.name, "Cornish Rex")
            XCTAssertEqual(breed.id, "crex")
            XCTAssertEqual(breed.temperament, "Affectionate, Intelligent, Active, Curious, Playful")
        default:
            XCTFail("Expected imageURLsLoaded state")
        }
    }

    @MainActor
    func testFetchData_FailureBothNetworkRequest() async {
        // Given
        catServiceMock.fetchRandomImageObjectResult = .success(
            ImageObject(
                id: "not used",
                url: URL(string: "www.google.com")!,
                breeds: nil,
                width: 20,
                height: 20
            )
        )

        catServiceMock.fetchImageObjectFromImageObjectIdResult = .failure(NSError(domain: "", code: 0))
        catServiceMock.fetchImageObjectsFromBreedIdResult = .failure(NSError(domain: "", code: 0))

        // When
        await sut.fetchData()

        // Then
        switch sut.state {
        case .errorLoadingBreed(let errorString):
            XCTAssertEqual(errorString, "The operation couldn’t be completed. ( error 0.)")
        default:
            XCTFail("Expected imageURLsLoaded state")
        }
    }
}
