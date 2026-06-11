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
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
