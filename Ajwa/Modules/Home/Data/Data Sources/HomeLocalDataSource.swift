//
//  HomeLocalDataSource.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

class HomeLocalDataSource : HomeLocalDataSourceProtocol {
    private let storageService: WeatherLocalStorageServiceProtocol

    init(storageService: WeatherLocalStorageServiceProtocol) {
        self.storageService = storageService
    }

    func saveMyLocation(_ response: WeatherResponse) {
        storageService.saveMyLocation(response)
    }

    func fetchMyLocation() -> MyLocationWeather? {
        storageService.fetchMyLocation()
    }

    func addFavourite(_ response: WeatherResponse) {
        storageService.addFavourite(response)
    }

    func removeFavourite(city: String) {
        storageService.removeFavourite(cityName: city)
    }

    func fetchAllFavourites() -> [FavouriteLocationWeather] {
        storageService.fetchAllFavourites()
    }

    func isFavourite(city: String) -> Bool {
        storageService.isFavourite(cityName: city)
    }
}
