//
//  FavouritesViewModel.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

class FavouritesViewModel : ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var favourites: [WeatherResponse] = []
    
    private var repo : HomeRepository?
    
    init(){}
    
    
    func setup(repo: HomeRepository) {
        guard self.repo == nil else { return }
        self.repo = repo
    }
    
    func fetchAllFavourites() {
        guard let repo else {
            errorMessage = "Repository not initialized"
            return
        }
        isLoading = true
        defer { isLoading = false }
        favourites = repo.fetchAllFavourites().map { $0.toWeatherResponse() }
        print("favourites count : \(favourites.count)")
    }

    func removeFavourite(cityName: String) {
        repo?.removeFavourite(cityName: cityName)
        fetchAllFavourites()
    }

    func isFavourite(cityName: String) -> Bool {
        repo?.isFavourite(cityName: cityName) ?? false
    }
    
    func toSearchResult(_ response: WeatherResponse) -> WeatherSearchResult {
        WeatherSearchResult(
            id: 0,
            name: response.location.name,
            region: response.location.region,
            country: response.location.country,
            lat: response.location.lat,
            lon: response.location.lon,
            url: ""
        )
    }
    
    
}
