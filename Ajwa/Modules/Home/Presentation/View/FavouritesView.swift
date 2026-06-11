//
//  FavouritesView.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct FavouritesView: View {
    @Environment(\.dismiss) private var dismiss

    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FavouritesViewModel()
    
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()

                ScrollView {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                        }
                        
                        ForEach(viewModel.favourites, id: \.location.name) { favourite in
                           NavigationLink {
                               DetailsView(city: viewModel.toSearchResult(favourite))
                           } label: {
                               CityWeatherSearchView(city: viewModel.toSearchResult(favourite))
                           }
                       }
                    }
                    .padding()
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(Text("Favourites"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
//                        Text("AddCity")
//                            .foregroundStyle(.primary)
                    }
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                }
            }
        }
        .onAppear {
            viewModel.setup(repo: HomeRepository(remoteDataSource: HomeRemoteDataSource(weatherService: WeatherApiService()), localDataSource:  HomeLocalDataSource(localStorageService: WeatherLocalStorageService(context: modelContext))))
            viewModel.fetchAllFavourites()
        }

    }
}

#Preview {
    FavouritesView()
}
