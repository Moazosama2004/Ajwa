//
//  WeatherApiService.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation
import CoreLocation

class WeatherApiService : WeatherServiceProtocol {
    // takes lang , lat -> WeatherResponse
    
    func fetchForecast(from location : CLLocation) async throws -> WeatherResponse {
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        let endpoint = ForeCastWeatherEndPoint.forecast(lat: lat, lon: long, days: 3, aqi: false, alerts: false)
        
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.uppercased()
        
        let (data , _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return response
    }
    
    func search(for text: String) async throws -> [WeatherSearchResult] {
        guard await NetworkMonitor.shared.isConnected else {
                throw URLError(.notConnectedToInternet)
        }
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let endpoint = WeatherSearchEndPoint.search(query: query)
        
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.uppercased()

        let (data, _) = try await URLSession.shared.data(for: request)

        let response = try JSONDecoder().decode([WeatherSearchResult].self, from: data)
        return response
    }
}



