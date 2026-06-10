//
//  CityWeatherSearchView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct CityWeatherSearchView: View {
    let city: WeatherSearchResult
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(city.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text("\(city.region), \(city.country)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("🌤️")
                    .font(.system(size: 28))
                
                Text("\(city.lat), \(city.lon)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
        }
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

//#Preview {
//    CityWeatherSearchView()
//}
