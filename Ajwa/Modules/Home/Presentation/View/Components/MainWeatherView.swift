//
//  MainWeatherView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct MainWeatherView: View {
    let weather: WeatherResponse
    private let theme = ThemeManager.shared.current

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Chance of rain \(chanceOfRainPercentage(from: weather.current.chanceOfRain))%")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(theme.contentColor.opacity(0.7))

                    Text(weather.current.condition.text)
                        .font(.system(size: 26, weight: .semibold, design: .rounded))
                        .foregroundStyle(theme.contentColor)
                }
                Spacer()
                Image(WeatherAsset.from(
                    code: weather.current.condition.code,
                    isDay: weather.current.isDay == 1
                ).rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            }

            
            HStack(spacing: 6) {
                Image(systemName: "location.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(theme.contentColor.opacity(0.8))
                Text("\(weather.location.name), \(weather.location.country)")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(theme.contentColor.opacity(0.8))
                    .lineLimit(1)
            }

            // MARK: - Precipitation
            HStack(spacing: 6) {
                Image(systemName: "cloud.moon.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(theme.contentColor.opacity(0.8))
                Text("No precipitation for at least 120min")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(theme.contentColor.opacity(0.8))
            }

            Divider()
                .overlay(theme.contentColor.opacity(0.3))

            // MARK: - Temp Row
            HStack(alignment: .bottom) {
                // Current temp
                HStack(alignment: .top, spacing: 2) {
                    Text("\(Int(weather.current.tempC))")
                        .font(.system(size: 52, weight: .thin, design: .rounded))
                        .foregroundStyle(theme.contentColor)
                    Text("°C")
                        .font(.system(size: 20, weight: .light, design: .rounded))
                        .foregroundStyle(theme.contentColor)
                        .padding(.top, 8)
                }

                Spacer()

                // Max / Min / Feels like
                VStack(alignment: .trailing, spacing: 6) {
                    HStack(spacing: 4) {
                        Image(.max)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("\(Int(weather.forecast.forecastday[0].day.maxtempC))°C")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(theme.contentColor)
                    }
                    HStack(spacing: 4) {
                        Image(.min)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("\(Int(weather.forecast.forecastday[0].day.mintempC))°C")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(theme.contentColor)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "thermometer.medium")
                            .font(.system(size: 12))
                            .foregroundStyle(theme.contentColor.opacity(0.7))
                        Text("Feels like \(Int(weather.current.feelslikeC))°C")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(theme.contentColor.opacity(0.7))
                    }
                }
            }
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(theme.contentColor == .white
                      ? Color.white.opacity(0.15)
                      : Color.black.opacity(0.08)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(theme.contentColor.opacity(0.2), lineWidth: 1)
                }
        }
    }
}

#Preview {
    MainWeatherView(weather: WeatherResponse(
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
    ))
}
