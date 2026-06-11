//
//  WeatherLocalStorageServiceProtocol.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

protocol WeatherLocalStorageServiceProtocol {
    func saveMyLocation(_ response: WeatherResponse)
    func fetchMyLocation() -> MyLocationWeather?

    func addFavourite(_ response: WeatherResponse)
    func removeFavourite(cityName: String)
    func fetchAllFavourites() -> [FavouriteLocationWeather]
    func isFavourite(cityName: String) -> Bool
}
