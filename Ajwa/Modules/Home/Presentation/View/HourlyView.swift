//
//  HourlyView.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct HourlyView: View {
    let day: ForecastDay

    private var filteredHours: [HourWeather] {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        return day.hour.filter { hour in
            guard let date = formatter.date(from: hour.time) else { return false }
            return date >= now
        }
    }
    
    private var navigationTitle: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let date = formatter.date(from: day.date) else { return day.date }
            let output = DateFormatter()
            output.dateFormat = "EEEE, d MMM"
            return output.string(from: date)
        }

    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(filteredHours.enumerated()), id: \.offset) { index, hour in
                        HourRowView(hour: hour, isFirst: index == 0)
                        
                        if index < filteredHours.count - 1 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    NavigationStack {
        HourlyView(day: ForecastDay(
            date: "2026-06-11",
            dateEpoch: 0,
            day: DaySummary(
                maxtempC: 38, maxtempF: 0,
                mintempC: 26, mintempF: 0,
                avgtempC: 33, avgtempF: 0,
                maxwindMph: 0, maxwindKph: 0,
                totalprecipMm: 0, totalprecipIn: 0,
                totalsnowCm: 0, avgvisKm: 0, avgvisMiles: 0,
                avghumidity: 40,
                dailyWillItRain: 0, dailyChanceOfRain: 0,
                dailyWillItSnow: 0, dailyChanceOfSnow: 0,
                condition: WeatherCondition(text: "Sunny", icon: "", code: 1000),
                uv: 8
            ),
            astro: Astro(
                sunrise: "", sunset: "",
                moonrise: "", moonset: "",
                moonPhase: "", moonIllumination: 0,
                isMoonUp: 0, isSunUp: 1
            ),
            hour: [
                HourWeather(
                    timeEpoch: 0,
                    time: "2026-06-11 15:00",
                    tempC: 15, tempF: 59,
                    isDay: 1,
                    condition: WeatherCondition(text: "Partly Cloudy", icon: "", code: 1003),
                    windMph: 0, windKph: 0, windDegree: 0, windDir: "",
                    pressureMb: 0, pressureIn: 0,
                    precipMm: 0, precipIn: 0,
                    snowCm: 0,
                    humidity: 0, cloud: 0,
                    feelslikeC: 0, feelslikeF: 0,
                    windchillC: 0, windchillF: 0,
                    heatindexC: 0, heatindexF: 0,
                    dewpointC: 0, dewpointF: 0,
                    willItRain: 0, chanceOfRain: 0,
                    willItSnow: 0, chanceOfSnow: 0,
                    visKm: 0, visMiles: 0,
                    gustMph: 0, gustKph: 0,
                    uv: 0
                ),
                HourWeather(
                    timeEpoch: 0,
                    time: "2026-06-11 15:00",
                    tempC: 15, tempF: 59,
                    isDay: 1,
                    condition: WeatherCondition(text: "Partly Cloudy", icon: "", code: 1003),
                    windMph: 0, windKph: 0, windDegree: 0, windDir: "",
                    pressureMb: 0, pressureIn: 0,
                    precipMm: 0, precipIn: 0,
                    snowCm: 0,
                    humidity: 0, cloud: 0,
                    feelslikeC: 0, feelslikeF: 0,
                    windchillC: 0, windchillF: 0,
                    heatindexC: 0, heatindexF: 0,
                    dewpointC: 0, dewpointF: 0,
                    willItRain: 0, chanceOfRain: 0,
                    willItSnow: 0, chanceOfSnow: 0,
                    visKm: 0, visMiles: 0,
                    gustMph: 0, gustKph: 0,
                    uv: 0
                )
            ]
        ))
    }
}
