//
//  WeatherServiceProtocol .swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func fetchForecast(from location: CLLocation) async throws -> WeatherResponse
    func search(for text: String) async throws -> [WeatherSearchResult]
}

extension EndPoint {
    var url: URL? {
        var components = URLComponents(string: baseUrl + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
