//
//  PreciptionView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct PreciptionView: View {
    let weather : WeatherResponse
    var body: some View {
        VStack(alignment: .leading, spacing:16) {
            VStack(alignment: .leading, spacing:4) {
                Text("Precipitation")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.secondary)
                
                Text("in last 24 hours")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(.primary)
            }
            
            Grid(horizontalSpacing: 12.0, verticalSpacing: 12.0){
                GridRow {
                    PerciptationItemView(title: "Humidity",imageIcon: .humidity , percentage: weather.current.humidity, color: "D7E6FF")
                    
                    PerciptationItemView(title: "Rain probability",imageIcon: .umbrella , percentage: chanceOfRainPercentage(from: weather.current.chanceOfRain), color: "D4ECFF")
                }
                
                GridRow {
                    
                    PerciptationItemView(title: "Dew Point",imageIcon: .temperatureLow , percentage: Int(weather.current.dewpointC), color: "D9FFF6")
                    
                    PerciptationItemView(title: "Cloud over",imageIcon: .cloudy , percentage: weather.current.cloud, color: "E5FCFF")
                }
            }
           
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(LinearGradient(colors: [.white , .white], startPoint: .bottomLeading, endPoint: .topTrailing))
           
            
        }
    }
}

#Preview {
    PreciptionView(weather: WeatherResponse.mock)
}
