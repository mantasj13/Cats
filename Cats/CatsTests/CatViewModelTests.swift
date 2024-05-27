//
//  CatViewModelTests.swift
//  CatsTests
//
//  Created by Mantas Jakstas on 3/5/24.
//

import XCTest
@testable import Cats

final class CatViewModelTests: XCTestCase {

    private var sut: CatViewModel!
    var apiMock: APIMock!

    @MainActor
    override func setUp() {
        apiMock = APIMock(fileName: "RandomImageObject")
        sut = CatViewModel(catService: CatsService(api: apiMock, service: ServiceURLFactory()))
    }

    override func tearDown() {
        sut = nil
    }

    @MainActor
    func test_fetchRandomImageObjectSuccess() async {

        //Given
        apiMock.fetchFailure = false
        await sut.fetchRandomImageObject()

        //When
        switch sut.state {
        case .loaded(let imageObject):
            //Then
            XCTAssertEqual(imageObject.id, "A5JigBZjG" )
            XCTAssertEqual(imageObject.url, URL(string: "https://cdn2.thecatapi.com/images/A5JigBZjG.jpg"))
            XCTAssertEqual(imageObject.width, 1040)
            XCTAssertEqual(imageObject.height, 1300)
        default:
            XCTFail("Unexpected state")
        }
    }

    @MainActor
    func test_FetchRandomCatFailure() async {

        //Given
        apiMock.fetchFailure = true
        await sut.fetchRandomImageObject()

        //When
        switch sut.state {
        case .errorLoading(let error):
            //Then
            XCTAssertEqual(error.localizedLowercase, "the operation couldn’t be completed. (error error 0.)")
        default:
            XCTFail("Unexpected state")
        }
    }
}
