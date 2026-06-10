//
//  HourlyForecastView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct HourlyForecastView: View {
    let hours: [HourWeather]

    var body: some View {
        VStack(spacing: 24) {

            HStack {
                Text(rainMessage)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)

                Spacer()

                Image(systemName: "chevron.right")
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 24) {

                    ForEach(upcomingHours.indices, id: \.self) { index in
                        let hour = hours[index]

                        VStack(spacing: 8) {

                            Text(hourLabel(for: hour, index: index))
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundStyle(.secondary)

                            Image(
                                WeatherAsset.from(
                                   code: hour.condition.code,
                                   isDay: hour.isDay == 1
                               ).rawValue
                            )
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)

                            Text("\(Int(hour.tempC))°C")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        }
    }
}

extension HourlyForecastView {

    private func hourLabel(for hour: HourWeather, index: Int) -> String {

        if index == 0 {
            return "Now"
        }

        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = input.date(from: hour.time) else {
            return "--"
        }

        let output = DateFormatter()
        output.dateFormat = "ha"

        return output.string(from: date)
    }

    private var rainMessage: String {

        if let rainyHour = hours.first(where: {
            $0.condition.text.lowercased().contains("rain")
        }) {

            let components = rainyHour.time.components(separatedBy: " ")

            if components.count > 1 {
                return "Rainy conditions expected around \(components[1])."
            }
        }

        return "No rain expected today."
    }
    
    private var upcomingHours: [HourWeather] {
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        return hours.filter { hour in
            guard let date = formatter.date(from: hour.time) else {
                return false
            }

            return date >= now
        }
    }
    
    	
}


//#Preview {
//    HourlyForecastView()
//}
