//
//  WeatherApiService.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation
import CoreLocation

class WeatherApiService {
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

protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
}

extension EndPoint {
    var url: URL? {
        var components = URLComponents(string: baseUrl + path)
        components?.queryItems = queryItems
        return components?.url
    }
}

enum ForeCastWeatherEndPoint: EndPoint {
    case forecast(lat: Double, lon: Double, days: Int = 3, aqi: Bool = false, alerts: Bool = false)

    var baseUrl: String { "https://api.weatherapi.com/v1" }

    var path: String {
        switch self {
        case .forecast: return "/forecast.json"
        }
    }

    var method: String { "GET" }

    var queryItems: [URLQueryItem] {
        switch self {
        case .forecast(let lat, let lon, let days, let aqi, let alerts):
            return [
                URLQueryItem(name: "key", value: Config.apikey),
                URLQueryItem(name: "q", value: "\(lat),\(lon)"),
                URLQueryItem(name: "days", value: "\(days)"),
                URLQueryItem(name: "aqi", value: aqi ? "yes" : "no"),
                URLQueryItem(name: "alerts", value: alerts ? "yes" : "no")
            ]
        }
    }
}

enum WeatherSearchEndPoint: EndPoint {
    case search(query: String)

    var baseUrl: String { "https://api.weatherapi.com/v1" }

    var path: String {
        switch self {
        case .search:
            return "/search.json"
        }
    }

    var method: String { "GET" }

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let query):
            return [
                URLQueryItem(name: "key", value: Config.apikey),
                URLQueryItem(name: "q", value: query)
            ]
        }
    }
}
