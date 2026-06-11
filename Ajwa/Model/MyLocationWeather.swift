//
//  MyLocationWeather.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class MyLocationWeather {
    var cityName: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    var tempC: Double
    var tempF: Double
    var conditionText: String
    var conditionIcon: String
    var conditionCode: Int
    var humidity: Int
    var windKph: Double
    var feelsLikeC: Double
    var isDay: Bool
    var lastUpdated: String
    var savedAt: Date
    var chanceOfRain: Int
    var uv: Double
    var visKm: Double
    var cloud: Int
    var precipMm: Double

    @Relationship(deleteRule: .cascade, inverse: \ForecastDayEntity.myLocationWeather)
    var forecastDays: [ForecastDayEntity] = []

    init(
        cityName: String, region: String, country: String,
        latitude: Double, longitude: Double,
        tempC: Double, tempF: Double,
        conditionText: String, conditionIcon: String, conditionCode: Int,
        humidity: Int, windKph: Double,
        feelsLikeC: Double, isDay: Bool,
        lastUpdated: String,
        chanceOfRain: Int, uv: Double,
        visKm: Double, cloud: Int, precipMm: Double
    ) {
        self.cityName = cityName; self.region = region; self.country = country
        self.latitude = latitude; self.longitude = longitude
        self.tempC = tempC; self.tempF = tempF
        self.conditionText = conditionText; self.conditionIcon = conditionIcon
        self.conditionCode = conditionCode
        self.humidity = humidity; self.windKph = windKph
        self.feelsLikeC = feelsLikeC; self.isDay = isDay
        self.lastUpdated = lastUpdated; self.savedAt = .now
        self.chanceOfRain = chanceOfRain; self.uv = uv
        self.visKm = visKm; self.cloud = cloud; self.precipMm = precipMm
    }
}

extension MyLocationWeather {
    func toWeatherResponse() -> WeatherResponse {
        WeatherResponse(
            location: Location(
                name: cityName, region: "", country: country,
                lat: latitude, lon: longitude,
                tzId: "", localtimeEpoch: 0, localtime: lastUpdated
            ),
            current: CurrentWeather(
                lastUpdatedEpoch: 0, lastUpdated: lastUpdated,
                tempC: tempC, tempF: tempF,
                isDay: isDay ? 1 : 0,
                condition: WeatherCondition(
                    text: conditionText,
                    icon: conditionIcon,
                    code: conditionCode
                ),
                windMph: 0, windKph: windKph, windDegree: 0, windDir: "",
                pressureMb: 0, pressureIn: 0, precipMm: precipMm, precipIn: 0,
                humidity: humidity, cloud: cloud,
                feelslikeC: feelsLikeC, feelslikeF: 0,
                windchillC: 0, windchillF: 0,
                heatindexC: 0, heatindexF: 0,
                dewpointC: 0, dewpointF: 0,
                visKm: visKm, visMiles: 0, uv: uv,
                gustMph: 0, gustKph: 0, chanceOfRain: chanceOfRain
            ),
            forecast: Forecast(
                forecastday: forecastDays
                    .sorted { $0.dateEpoch < $1.dateEpoch }
                    .map { day in
                        ForecastDay(
                            date: day.date,
                            dateEpoch: day.dateEpoch,
                            day: DaySummary(
                                maxtempC: day.maxTempC, maxtempF: 0,
                                mintempC: day.minTempC, mintempF: 0,
                                avgtempC: day.avgTempC, avgtempF: 0,
                                maxwindMph: 0, maxwindKph: 0,
                                totalprecipMm: 0, totalprecipIn: 0,
                                totalsnowCm: 0, avgvisKm: 0, avgvisMiles: 0,
                                avghumidity: day.humidity,
                                dailyWillItRain: 0,
                                dailyChanceOfRain: day.chanceOfRain,
                                dailyWillItSnow: 0, dailyChanceOfSnow: 0,
                                condition: WeatherCondition(
                                    text: day.conditionText,
                                    icon: day.conditionIcon,
                                    code: day.conditionCode
                                ),
                                uv: day.uv
                            ),
                            astro: Astro(
                                sunrise: "", sunset: "",
                                moonrise: "", moonset: "",
                                moonPhase: "", moonIllumination: 0,
                                isMoonUp: 0, isSunUp: 0
                            ),
                            hour: []
                        )
                    }
            )
        )
    }
}
