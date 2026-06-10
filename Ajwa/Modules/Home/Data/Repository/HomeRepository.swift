//
//  HomeRepository.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation
import CoreLocation

class HomeRepository {
    private let remoteDataSource : HomeRemoteDataSource
    
    init(remoteDataSource: HomeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchForecast(from location : CLLocation) async throws -> WeatherResponse {
        try await remoteDataSource.fetchForecast(from: location)
    }
}


