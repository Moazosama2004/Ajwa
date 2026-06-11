//
//  HomeRemoteDataSourceProtocol .swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation
import CoreLocation

protocol HomeRemoteDataSourceProtocol {
    func fetchForecast(from location: CLLocation) async throws -> WeatherResponse
}
