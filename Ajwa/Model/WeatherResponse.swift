//
//  WeatherResponse.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import Foundation

struct WeatherResponse : Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

#if DEBUG
extension WeatherResponse {
    static let mock = WeatherResponse(
        location: Location(
            name: "Cairo",
            region: "Al Qahirah",
            country: "Egypt",
            lat: 30.0444,
            lon: 31.2357,
            tzId: "Africa/Cairo",
            localtimeEpoch: 1781049616,
            localtime: "2026-06-10 03:00"
        ),
        current: CurrentWeather(
            lastUpdatedEpoch: 1781048700,
            lastUpdated: "2026-06-10 03:00",
            tempC: 33,
            tempF: 91.4,
            isDay: 1,
            condition: WeatherCondition(
                text: "Sunny",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                code: 1000
            ),
            windMph: 8.5,
            windKph: 13.7,
            windDegree: 250,
            windDir: "WSW",
            pressureMb: 1015,
            pressureIn: 29.97,
            precipMm: 0,
            precipIn: 0,
            humidity: 40,
            cloud: 0,
            feelslikeC: 31.0,
            feelslikeF: 87.8,
            windchillC: 33.0,
            windchillF: 91.4,
            heatindexC: 34.0,
            heatindexF: 93.2,
            dewpointC: 18.0,
            dewpointF: 64.4,
            visKm: 10,
            visMiles: 6,
            uv: 8,
            gustMph: 12.5,
            gustKph: 20.2,
            chanceOfRain: 4
        ),
        forecast: Forecast(forecastday: [
            ForecastDay(
                date: "2026-06-10",
                dateEpoch: 1781049616,
                day: DaySummary(
                    maxtempC: 38, maxtempF: 100.4,
                    mintempC: 26, mintempF: 78.8,
                    avgtempC: 33, avgtempF: 91.4,
                    maxwindMph: 14, maxwindKph: 22.5,
                    totalprecipMm: 0, totalprecipIn: 0,
                    totalsnowCm: 0,
                    avgvisKm: 10, avgvisMiles: 6,
                    avghumidity: 40,
                    dailyWillItRain: 0, dailyChanceOfRain: 0,
                    dailyWillItSnow: 0, dailyChanceOfSnow: 0,
                    condition: WeatherCondition(
                        text: "Sunny",
                        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                        code: 1000
                    ),
                    uv: 8
                ),
                astro: Astro(
                    sunrise: "05:12 AM", sunset: "07:45 PM",
                    moonrise: "08:30 PM", moonset: "04:15 AM",
                    moonPhase: "Waxing Gibbous",
                    moonIllumination: 75,
                    isMoonUp: 0, isSunUp: 1
                ),
                hour: []
            )
        ])
    )
}
#endif
