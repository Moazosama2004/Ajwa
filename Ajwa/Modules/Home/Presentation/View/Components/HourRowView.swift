//
//  HourRowView.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct HourRowView: View {
    let hour: HourWeather
    let isFirst: Bool

    private var timeLabel: String {
        if isFirst { return "Now" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: hour.time) else { return hour.time }
        let output = DateFormatter()
        output.dateFormat = "ha" // e.g. 3PM
        return output.string(from: date)
    }

    var body: some View {
        HStack(spacing: 16) {
            Text(timeLabel)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundStyle(.primary)
                .frame(width: 70, alignment: .leading)

            Spacer()

            Image(WeatherAsset.from(
                code: hour.condition.code,
                isDay: hour.isDay == 1
            ).rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: 36, height: 36)

            Spacer()

            Text("\(Int(hour.tempC))°")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundStyle(.primary)
                .frame(width: 50, alignment: .trailing)
        }        
        .padding()
        .background {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(LinearGradient(colors: [.white , .white], startPoint: .bottomLeading, endPoint: .topTrailing))
            
        }
        .padding(.vertical)
    
    }
}

#Preview {
    HourRowView(
        hour: HourWeather(
            timeEpoch: 0,
            time: "2026-06-11 15:00",
            tempC: 15, tempF: 59,
            isDay: 1,
            condition: WeatherCondition(text: "Partly Cloudy", icon: "", code: 1003),
            windMph: 0, windKph: 0, windDegree: 0, windDir: "",
            pressureMb: 0, pressureIn: 0,
            precipMm: 0, precipIn: 0, snowCm: 0,
            humidity: 0, cloud: 0,
            feelslikeC: 0, feelslikeF: 0,
            windchillC: 0, windchillF: 0,
            heatindexC: 0, heatindexF: 0,
            dewpointC: 0, dewpointF: 0,
            willItRain: 0, chanceOfRain: 0,
            willItSnow: 0, chanceOfSnow: 0,
            visKm: 0, visMiles: 0,
            gustMph: 0, gustKph: 0, uv: 0
        ),
        isFirst: true
    )
}
