//
//  WeatherCondition.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
    
    var iconURL: URL? { URL(string: "https:\(icon)") }
}
