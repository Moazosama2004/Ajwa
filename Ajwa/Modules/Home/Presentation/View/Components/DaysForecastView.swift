//
//  DaysForecastView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct DaysForecastView: View {
    
    let days: [ForecastDay]
    
    private var globalMinTemp: Double {
        days.map { $0.day.mintempC }.min() ?? 0
    }
    
    private var globalMaxTemp: Double {
        days.map { $0.day.maxtempC }.max() ?? 0
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Forecast")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                    
                    Text("3-DAY FORECAST")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .italic()
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            
            ForEach(days.indices, id: \.self) { index in
                let forecastDay = days[index]

                NavigationLink {
                    HourlyView(day: forecastDay)
                } label: {
                    HStack(spacing: 12) {

                        Image(WeatherAsset.from(
                            code: forecastDay.day.condition.code,
                            isDay: true
                        ).rawValue)
                        .frame(width: 32, height: 32)

                        Text(
                            dayName(
                                from: forecastDay.date,
                                isToday: index == 0
                            )
                        )
                        .font(.system(size: 16, weight: .medium))

                        Spacer()

                        TemperatureRangeIndicatorView(
                            minDayTemp: globalMinTemp,
                            maxDayTemp: globalMaxTemp,
                            currentMinTemp: forecastDay.day.mintempC,
                            currentMaxTemp: forecastDay.day.maxtempC,
                            currentTemp: (forecastDay.day.mintempC + forecastDay.day.maxtempC) / 2
                        )
                    }
                }


                if index < days.count - 1 {
                    Divider()
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        }
    }
    
    private func dayName(from dateString: String, isToday: Bool) -> String {
        if isToday { return "Today" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

//#Preview {
//    DaysForecastView()
//}
