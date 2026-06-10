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
