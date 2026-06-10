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

    private let repo: HomeRepository

    init(repo: HomeRepository) {
        self.repo = repo
    }

    func loadWeather(from city: WeatherSearchResult) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let location = CLLocation(latitude: city.lat, longitude: city.lon)
            weather = try await repo.fetchForecast(from: location)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
