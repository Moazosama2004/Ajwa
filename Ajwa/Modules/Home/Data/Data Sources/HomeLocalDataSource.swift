//
//  HomeLocalDataSource.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

class HomeLocalDataSource {
    private let localStorageService : WeatherLocalStorageServiceProtocol
    
    init(localStorageService: WeatherLocalStorageServiceProtocol) {
        self.localStorageService = localStorageService
    }
    
    func saveMyLocation(_ response: WeatherResponse) {
        localStorageService.saveMyLocation(response)
    }
    
    func fetchMyLocation() -> MyLocationWeather? {
        localStorageService.fetchMyLocation()
    }
    
    func addFavourite(_ response: WeatherResponse) {
        localStorageService.addFavourite(response)
    }
    
    func removeFavourite(city: String) {
        localStorageService.removeFavourite(cityName: city)
    }
    
    func fetchAllFavourites() -> [FavouriteLocationWeather] {
        localStorageService.fetchAllFavourites()
    }
    
    func isFavourite(city: String) -> Bool {
        localStorageService.isFavourite(cityName: city)
    }
}





