//
//  ForecastDay.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation

struct ForecastDay: Codable {
    let date: String
    let dateEpoch: Int
    let day: DaySummary
    let astro: Astro
    let hour: [HourWeather]

    enum CodingKeys: String, CodingKey {
        case date, day, astro, hour
        case dateEpoch = "date_epoch"
    }
}
