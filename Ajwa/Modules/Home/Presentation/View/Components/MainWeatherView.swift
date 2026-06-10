//
//  MainWeatherView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct MainWeatherView: View {
    let weather : WeatherResponse
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                VStack(alignment: .leading, spacing: 8){
                    Text("Chance of rain \(chanceOfRainPercentage(from: weather.current.chanceOfRain))%")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                    Text(weather.current.condition.text)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                }
                Spacer()
                Image(WeatherAsset.from(
                    code: weather.current.condition.code,
                    isDay: weather.current.isDay == 1
                ).rawValue
                )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72 , height: 72)
            }
            
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20 , height: 20)
                Text("\(weather.location.name), \(weather.location.country)")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            
            HStack {
                Image(systemName: "cloud.moon.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20 , height: 20)
                Text("No precipitation for at least 120min")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            
            HStack {
                HStack(alignment: .top) {
                    Text("\(Int(weather.current.tempC))")
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                    Text("°C")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                }
            
                Spacer()
                HStack() {
                    HStack {
                        Image(.max)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20 , height: 20)
                        Text("\(Int(weather.forecast.forecastday[0].day.maxtempC))°C")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(.leading , 8.0)
                   
                    HStack {
                        Image(.min)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20 , height: 20)
                        Text("\(Int(weather.forecast.forecastday[0].day.mintempC))°C")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(.leading , 8.0)
                    
                    HStack {

                        Text("Feels like")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                        Text("\(Int(weather.current.feelslikeC))°C")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
            }
            
           
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: "3C6FD1"), Color(hex: "7CA9FF"),
                               ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
               
           
            
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
