//
//  HomeRepository.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation
import CoreLocation

class HomeRepository : HomeRepoProtocol {
    private let remoteDataSource: HomeRemoteDataSourceProtocol
    private let localDataSource: HomeLocalDataSourceProtocol
    
    init(
        remoteDataSource: HomeRemoteDataSourceProtocol,
        localDataSource: HomeLocalDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchWeatherData(from location: CLLocation) async throws -> WeatherResponse {
        do {
            let response = try await remoteDataSource.fetchForecast(from: location)
            localDataSource.saveMyLocation(response)
            return response
        } catch {
            if let cached = localDataSource.fetchMyLocation() {
                return cached.toWeatherResponse()
            }
            throw error
        }
    }
    
//    func fetchForecast(from location : CLLocation) async throws -> WeatherResponse {
//        try await remoteDataSource.fetchForecast(from: location)
//    }
    
    func saveMyLocation(_ response: WeatherResponse) {
        localDataSource.saveMyLocation(response)
    }
    
    func fetchMyLocation() -> MyLocationWeather? {
        localDataSource.fetchMyLocation()
    }
    
    func addFavourite(_ response: WeatherResponse) {
        localDataSource.addFavourite(response)
    }
    
    func removeFavourite(cityName: String) {
        localDataSource.removeFavourite(city: cityName)
    }
    
    func fetchAllFavourites() -> [FavouriteLocationWeather] {
        localDataSource.fetchAllFavourites()
    }
    
    func isFavourite(cityName: String) -> Bool {
        localDataSource.isFavourite(city: cityName)
    }
    
}


