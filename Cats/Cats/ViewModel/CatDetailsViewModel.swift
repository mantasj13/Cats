//
//  CatDetailsViewModel.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import Foundation

@MainActor
final class CatDetailsViewModel: ObservableObject {

    enum State {
        case idle
        case loadingBreed
        case errorLoadingBreed(String)
        case breedLoaded(breed: Breed, breedImagesState: BreedImagesState)
    }

    enum BreedImagesState {
        case idle
        case loadingImages
        case errorLoadingImages(String)
        case imageURLsLoaded(breedImageURLs: [URL])
    }

    var isRefreshButtonEnabled: Bool {
        if case .breedLoaded(_, .imageURLsLoaded) = state {
            return true
        }
        return false
    }

    @Published var state = State.idle

    private let imageObjectId: String
    private let catService: CatsServiceProtocol

    init(imageObjectId: String, catService: CatsServiceProtocol = CatsService()) {
        self.imageObjectId = imageObjectId
        self.catService = catService
    }

    func fetchData() async {
        await fetchBreed()
        await fetchBreedImageURLs()
    }

    private func fetchBreed() async {
        state = .loadingBreed
        do {
            let imageObject = try await catService.fetchImageObjectFromImageObjectId(imageObjectId)

            guard let breed = imageObject.breeds?.first else {
                throw CatsServiceError.noObjects
            }

            state = .breedLoaded(breed: breed, breedImagesState: .idle)
        } catch {
            state = .errorLoadingBreed(error.localizedDescription)
        }
    }

    func fetchBreedImageURLs() async {
        switch state {
        case .breedLoaded(let breed, _):
            do {
                state = .breedLoaded(breed: breed, breedImagesState: .loadingImages)
                let imageObjects = try await catService.fetchImageObjectsFromBreedId(breed.id)
                let imageURLs = imageObjects.map(\.url)
                state = .breedLoaded(breed: breed, breedImagesState: .imageURLsLoaded(breedImageURLs: imageURLs))
            } catch {
                state = .breedLoaded(breed: breed, breedImagesState: .errorLoadingImages("Error loading breed image URLs"))
            }
        default:
            break
        }
    }
}
