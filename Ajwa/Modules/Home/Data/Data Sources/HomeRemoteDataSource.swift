//
//  HomeLocalDataSource.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation
import CoreLocation

class HomeRemoteDataSource : HomeRemoteDataSourceProtocol {
    private let weatherService : WeatherApiService
    
    init(weatherService: WeatherApiService) {
        self.weatherService = weatherService
    }
    
    func fetchForecast(from location : CLLocation) async throws -> WeatherResponse {
        try await weatherService.fetchForecast(from: location)
    }
}
