//
//  DetailsViewModel.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation
import CoreLocation

@MainActor
class DetailsViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isFavourite = false

    private var repo: HomeRepository?

    init() {}

    func setup(repo: HomeRepository) {
        guard self.repo == nil else { return }
        self.repo = repo
    }
  
    func loadWeather(from city: WeatherSearchResult) async {
        guard let repo else {
            errorMessage = "Repository not initialized"
            return
        }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let location = CLLocation(latitude: city.lat, longitude: city.lon)
            weather = try await repo.fetchWeatherData(from: location)
            isFavourite = repo.isFavourite(cityName: city.name)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleFavourite() {
        guard let weather else { return }
        if isFavourite {
            repo?.removeFavourite(cityName: weather.location.name)
        } else {
            repo?.addFavourite(weather)
        }
        isFavourite.toggle()
    }
}
