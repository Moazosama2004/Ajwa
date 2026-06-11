//
//  ForecastDayEntity .swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class ForecastDayEntity {
    var date: String
    var dateEpoch: Int
    var maxTempC: Double
    var minTempC: Double
    var avgTempC: Double
    var conditionText: String
    var conditionIcon: String
    var conditionCode: Int
    var humidity: Int
    var chanceOfRain: Int
    var uv: Double

    // Back-references (only one will be set)
    var myLocationWeather: MyLocationWeather?
    var favouriteLocationWeather: FavouriteLocationWeather?

    init(
        date: String, dateEpoch: Int,
        maxTempC: Double, minTempC: Double, avgTempC: Double,
        conditionText: String, conditionIcon: String, conditionCode: Int,
        humidity: Int, chanceOfRain: Int, uv: Double
    ) {
        self.date = date; self.dateEpoch = dateEpoch
        self.maxTempC = maxTempC; self.minTempC = minTempC; self.avgTempC = avgTempC
        self.conditionText = conditionText
        self.conditionIcon = conditionIcon
        self.conditionCode = conditionCode
        self.humidity = humidity; self.chanceOfRain = chanceOfRain; self.uv = uv
    }
}
