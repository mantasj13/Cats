//
//  DetailsCatView.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct DetailsCatView: View {

    @StateObject private var viewModel: CatDetailsViewModel

    private let columns = [GridItem(.adaptive(minimum: 120), spacing: 30)]

    init(imageObjectId: String) {
        _viewModel = StateObject(wrappedValue: CatDetailsViewModel(imageObjectId: imageObjectId))
    }

    var body: some View {

        VStack {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loadingBreed:
                ProgressView()
            case .errorLoadingBreed(let message):
                ErrorLoadingView(errorMessage: message) {
                    Task {
                        await viewModel.fetchData()
                    }
                }
            case .breedLoaded(let breeds, let stateImages):
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 8) {

                        InfoView(breed: breeds)
                        CatButton(title: "Refresh other images") {
                            Task {
                                await viewModel.fetchBreedImageURLs()
                            }
                        }
                        .padding(.horizontal, 10)
                        .disabled(!viewModel.isRefreshButtonEnabled)

                        switch stateImages {
                        case .idle:
                            EmptyView()
                        case .loadingImages:
                            HStack{
                                ProgressView("Loading...")
                            }
                            .offset(x: 170, y: 100)
                        case .errorLoadingImages(let errorMessage):
                            ErrorLoadingView(errorMessage: errorMessage) {
                                Task {
                                    await viewModel.fetchData()
                                }
                            }
                        case .imageURLsLoaded(let breedImageURLs):
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 8) {
                                    LazyVGrid(columns: columns) {
                                        ForEach(breedImageURLs, id: \.self) { imageURL in
                                            BreedCardImage(imageURL: imageURL)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}
