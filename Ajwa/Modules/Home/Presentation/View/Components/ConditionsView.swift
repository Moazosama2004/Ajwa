//
//  ConditionsView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct ConditionsView: View {
    let weather : WeatherResponse
    var body: some View {
        VStack(alignment: .leading, spacing:16) {
                HStack() {
                    VStack(alignment: .leading, spacing:4) {
                        Text("Conditions")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.secondary)
                        
                        Text("Pressure")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundStyle(.primary)
            }
            
            HStack() {
                Image(.pressure)
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 48, weight: .regular))
                    .frame(width: 48,height: 48)
                
                Spacer()
                
                VStack(alignment: .leading, spacing:4) {
                    Text("Speed")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                    
                    Text("\(Int((weather.current.windMph))) mp/h")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing:4) {
                    Text("Barrometer")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                    
                    Text("\(Int(weather.current.pressureMb)) mBar")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.primary)
                }
                Spacer()
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
    ConditionsView(weather: WeatherResponse.mock)
}
