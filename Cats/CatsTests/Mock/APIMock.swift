//
//  APIMock.swift
//  CatsTests
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

@testable import Cats

final class APIMock: APIProtocol {

    private let fileName: String
    var fetchFailure = true

    init(fileName: String) {
        self.fileName = fileName
    }

    func fetch<T: Decodable>(url: URL) async throws -> T {

        if !fetchFailure {
            guard let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else {
                throw NetworkingError.invalidURL
            }

            let data = try Data(contentsOf: url)

            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkingError.invalidDecodedData
            }
            return response
        } else {
            throw NSError(domain: "Error", code: 0)
        }
    }
}
