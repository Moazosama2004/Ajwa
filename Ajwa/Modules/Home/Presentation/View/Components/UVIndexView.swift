//
//  UVIndexView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct UVIndexView: View {
    let weather: WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing:16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing:4) {
                    Text("UV index")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 4) {
                        Text("\(String(format: "%0.1f" , weather.current.uv))")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary)
                        
                        Text("Moderate")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.primary)
            }
            
            UVIndexIndicatorView(uvValue: weather.current.uv)
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(LinearGradient(colors: [.white , .white], startPoint: .bottomLeading, endPoint: .topTrailing))
        }
    }
}

#Preview {
    UVIndexView(weather: WeatherResponse.mock)
}
