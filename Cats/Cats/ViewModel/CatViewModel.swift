//
//  CatViewModel.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

@MainActor
final class CatViewModel: ObservableObject {

    enum State {
        case idle
        case loading
        case errorLoading(String)
        case loaded(ImageObject)
    }

    var isFetchButtonEnabled: Bool {
        if case .loaded = state {
            return true
        }
        return false
    }

    @Published  var state = State.idle
    private let catService: CatsServiceProtocol

    init(catService: CatsServiceProtocol = CatsService()) {
        self.catService = catService
    }

    func fetchRandomImageObject() async {
        state = .loading
        do {
            let imageObject = try await catService.fetchRandomImageObject()
            state = .loaded(imageObject)
        } catch {
            state = .errorLoading(error.localizedDescription)
        }
    }
}
