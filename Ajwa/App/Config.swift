//
//  config.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation

enum Config {
    static var apikey : String {
        Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String ?? ""
    }
}
