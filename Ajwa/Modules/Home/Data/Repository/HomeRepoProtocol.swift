//
//  HomeRepoProtocol.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation
import CoreLocation

protocol HomeRepoProtocol {
    
    func fetchWeatherData(from location: CLLocation) async throws -> WeatherResponse
    
    func saveMyLocation(_ response: WeatherResponse)
    func fetchMyLocation() -> MyLocationWeather?
    
    func addFavourite(_ response: WeatherResponse)
    func removeFavourite(cityName: String)
    
    func fetchAllFavourites() -> [FavouriteLocationWeather]
    func isFavourite(cityName: String) -> Bool
}
