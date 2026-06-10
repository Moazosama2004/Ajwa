//
//  Visibility.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct VisibilityView: View {
    let weather : WeatherResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing:4) {
            HStack() {
                Text("Visibility")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.primary)
            }
            
            HStack() {
                HStack(alignment: .top, spacing:8) {
                    Image(.eyeAlt)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.purple)
                    
                    Text("Poor visibility, vision’s not clear")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary)
                }
                Spacer()
                Text("\(Int((weather.current.visKm))) Km")
                    .font(.system(size: 34, weight: .regular, design: .rounded))
                    .foregroundStyle(.primary)
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
    VisibilityView(weather: WeatherResponse.mock)
}
