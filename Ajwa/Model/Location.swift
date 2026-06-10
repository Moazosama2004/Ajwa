//
//  Location.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation

struct Location : Codable {
    let name: String //  "London",
    let region: String  // "City of London, Greater London",
    let country: String //  "United Kingdom",
    let lat: Double //51.5171,
    let lon: Double  //-0.1062,
    let tzId: String  // "Europe/London",
    let localtimeEpoch: Int // 1781049616,
    let localtime: String  // "2026-06-10 01:00"
    
    enum CodingKeys : String , CodingKey {
        case name, region, country, lat, lon, localtime
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
    }
    
    var displayName: String { "\(name), \(country)" }
}
