//
//  ServiceURLFactoryTests.swift
//  CatsTests
//
//  Created by Mantas Jakstas on 3/5/24.
//

import XCTest
@testable import Cats

final class ServiceURLFactoryTests: XCTestCase {

    func test_makeImageObjectsRandomURSuccess() {
        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectsRandomURL()

        XCTAssertEqual(url, URL(string: "https://api.thecatapi.com/v1/images/search?has_breeds=1?api_key=live_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }

    func test_makeImageObjectsRandomURLFailure() {
        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectsRandomURL()

        XCTAssertNotEqual(url, URL(string: "https://api.thecatapi.com/v1/images/search?api_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }

    func test_makeImageObjectURLSuccess() {

        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectURL(imageObjectId: "abc")

        XCTAssertEqual(url, URL(string: "https://api.thecatapi.com/v1/images/abc?api_key=live_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }

    func test_makeImageObjectURFailure() {

        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectURL(imageObjectId: "ab765")

        XCTAssertNotEqual(url, URL(string: "https://api.thecatapi.com/v1/images/abc?api_key=live_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }

    func test_makeImageObjectsURLFromBreedSuccess() {

        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectsURLFromBreed(breedId: "XXXWWW")

        XCTAssertEqual(url, URL(string: "https://api.thecatapi.com/v1/images/search?limit=4&breed_ids=XXXWWW&api_key=live_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }

    func test_makeImageObjectsURLFromBreedFailure() {

        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.thecatapi.com/v1/images")!)
        let url = sut.makeImageObjectsURLFromBreed(breedId: "sibu")
        XCTAssertNotEqual(url, URL(string: "https://api.thecatapi.com/v1/images/search?limit=4&breed_ids=XXXWWW&api_key=live_ebTG4OaQ12BH88K9VyrVDmf9ndBzJ5x6BCu9kma4ttrZhwlVcmaaCb4MjhPTMMV6"))
    }
}
