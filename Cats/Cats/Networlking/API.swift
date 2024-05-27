//
//  API.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

protocol APIProtocol {
    func fetch<T: Decodable> (url: URL) async throws -> T
}

final class API: APIProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable> (url: URL) async throws -> T {

        let (data, response) = try await urlSession.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }

        guard 200...299 ~= response.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: response.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkingError.invalidDecodedData
        }
    }
}
