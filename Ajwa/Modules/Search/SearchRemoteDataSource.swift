//
//  SearchRemoteDataSource.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

class SearchRemoteDataSource {
    private let weatherService : WeatherApiService
    
    init(weatherService: WeatherApiService) {
        self.weatherService = weatherService
    }
    
    func search(for query : String) async throws -> [WeatherSearchResult] {
        try await weatherService.search(for: query)
    }
}
