//
//  WeatherSearchEndPoint.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

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
