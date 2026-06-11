//
//  HomeLocalDataSourceProtocol.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

protocol HomeLocalDataSourceProtocol {
    func saveMyLocation(_ response: WeatherResponse)
    func fetchMyLocation() -> MyLocationWeather?
    
    func addFavourite(_ response: WeatherResponse)
    func removeFavourite(city: String)
    
    func fetchAllFavourites() -> [FavouriteLocationWeather]
    func isFavourite(city: String) -> Bool
}
