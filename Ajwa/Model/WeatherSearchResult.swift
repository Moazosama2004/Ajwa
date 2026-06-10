//
//  WeatherSearchResult.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

struct WeatherSearchResult: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}


extension WeatherSearchResult {
    static var mock: WeatherSearchResult {
        WeatherSearchResult(id: 1, name: "Cairo", region: "Egypt", country: "Egypt", lat: 1.053, lon: -10.026, url: "dddd")
    }
}
