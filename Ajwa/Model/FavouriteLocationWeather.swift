//
//  FavouriteLocationWeather.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation
import SwiftData

@Model
final class FavouriteLocationWeather {
    var cityName: String
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
    
    @Relationship(deleteRule: .cascade, inverse: \ForecastDayEntity.favouriteLocationWeather)
    var forecastDays: [ForecastDayEntity] = []

    init(
        cityName: String, country: String,
        latitude: Double, longitude: Double,
        tempC: Double, tempF: Double,
        conditionText: String, conditionIcon: String, conditionCode: Int,
        humidity: Int, windKph: Double,
        feelsLikeC: Double, isDay: Bool,
        lastUpdated: String
    ) {
        self.cityName = cityName; self.country = country
        self.latitude = latitude; self.longitude = longitude
        self.tempC = tempC; self.tempF = tempF
        self.conditionText = conditionText; self.conditionIcon = conditionIcon
        self.conditionCode = conditionCode
        self.humidity = humidity; self.windKph = windKph
        self.feelsLikeC = feelsLikeC; self.isDay = isDay
        self.lastUpdated = lastUpdated; self.savedAt = .now
    }
}


struct WeatherModelMapper {

    static func forecastDays(from r: WeatherResponse) -> [ForecastDayEntity] {
        r.forecast.forecastday.map { day in
            ForecastDayEntity(
                date: day.date,
                dateEpoch: day.dateEpoch,
                maxTempC: day.day.maxtempC,
                minTempC: day.day.mintempC,
                avgTempC: day.day.avgtempC,
                conditionText: day.day.condition.text,
                conditionIcon: day.day.condition.icon,
                conditionCode: day.day.condition.code,
                humidity: day.day.avghumidity,
                chanceOfRain: day.day.dailyChanceOfRain,
                uv: day.day.uv
            )
        }
    }

    static func toMyLocation(from r: WeatherResponse) -> MyLocationWeather {
        let model = MyLocationWeather(
            cityName: r.location.name, country: r.location.country,
            latitude: r.location.lat, longitude: r.location.lon,
            tempC: r.current.tempC, tempF: r.current.tempF,
            conditionText: r.current.condition.text,
            conditionIcon: r.current.condition.icon,
            conditionCode: r.current.condition.code,
            humidity: r.current.humidity, windKph: r.current.windKph,
            feelsLikeC: r.current.feelslikeC,
            isDay: r.current.isDay == 1,
            lastUpdated: r.current.lastUpdated
        )
        model.forecastDays = forecastDays(from: r)
        return model
    }

    static func toFavourite(from r: WeatherResponse) -> FavouriteLocationWeather {
        let model = FavouriteLocationWeather(
            cityName: r.location.name, country: r.location.country,
            latitude: r.location.lat, longitude: r.location.lon,
            tempC: r.current.tempC, tempF: r.current.tempF,
            conditionText: r.current.condition.text,
            conditionIcon: r.current.condition.icon,
            conditionCode: r.current.condition.code,
            humidity: r.current.humidity, windKph: r.current.windKph,
            feelsLikeC: r.current.feelslikeC,
            isDay: r.current.isDay == 1,
            lastUpdated: r.current.lastUpdated
        )
        model.forecastDays = forecastDays(from: r)
        return model
    }
}
