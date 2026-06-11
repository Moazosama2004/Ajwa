//
//  WeatherModelMapper.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

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
            cityName: r.location.name,
            region: r.location.region,
            country: r.location.country,

            latitude: r.location.lat,
            longitude: r.location.lon,

            tempC: r.current.tempC,
            tempF: r.current.tempF,

            conditionText: r.current.condition.text,
            conditionIcon: r.current.condition.icon,
            conditionCode: r.current.condition.code,

            humidity: r.current.humidity,
            windKph: r.current.windKph,
            feelsLikeC: r.current.feelslikeC,

            isDay: r.current.isDay == 1,
            lastUpdated: r.current.lastUpdated,

            chanceOfRain: r.current.chanceOfRain ?? 0,
            uv: r.current.uv,
            visKm: r.current.visKm,
            cloud: r.current.cloud,
            precipMm: r.current.precipMm
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
