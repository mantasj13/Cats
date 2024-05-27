//
//  CatView.swift
//  Cats
//
//  Created by Mantas Jakstas on 3/5/24.
//

import SwiftUI

struct CatView: View {

    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .errorLoading(let error):
                    ErrorLoadingView(errorMessage: error) {
                        Task {
                            await viewModel.fetchRandomImageObject()
                        }
                    }
                case .loaded(let imageObject):
                    VStack {
                        Spacer()
                        NavigationLink(
                            destination: DetailsCatView(imageObjectId: imageObject.id)
                        ) {
                            CardView(cat: imageObject, imageURL: imageObject.url, targetSize: CGSize(width: 350, height: 350))
                        }
                        Spacer()
                    }
                }
                Spacer()

                CatButton(title: "Fetch random cat") {
                    Task {
                        await viewModel.fetchRandomImageObject()
                    }
                }
                .disabled(!viewModel.isFetchButtonEnabled)
                .padding()
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchRandomImageObject()
            }
        }
    }
}

#Preview {
    CatView()
}
