//
//  ForeCastWeatherEndPoint.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

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

