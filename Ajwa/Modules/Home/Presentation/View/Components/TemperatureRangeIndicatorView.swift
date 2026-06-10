//
//  TemperatureRangeIndicatorView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct TemperatureRangeIndicatorView: View {
    // Input values from your weather API/Data source
    let minDayTemp: Double      // e.g., 20°C (Lowest temperature of the entire day)
    let maxDayTemp: Double      // e.g., 40°C (Highest temperature of the entire day)
    let currentMinTemp: Double  // e.g., 28°C (Start of the colored forecast block)
    let currentMaxTemp: Double  // e.g., 38°C (End of the colored forecast block)
    let currentTemp: Double     // e.g., 34°C (The dot indicator position)
    
    var body: some View {
        HStack(spacing: 12) {
            // Left Label: Minimum active temperature
            Text("\(Int(currentMinTemp))°")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.2, green: 0.25, blue: 0.4))
                .frame(width: 36, alignment: .leading)
            
            // The Range Bar Layout
            GeometryReader { geometry in
                let width = geometry.size.width
                let totalRange = maxDayTemp - minDayTemp
                
                // 1. Calculate positions for the active colored segment
                let startX = CGFloat((currentMinTemp - minDayTemp) / totalRange) * width
                let endX = CGFloat((currentMaxTemp - minDayTemp) / totalRange) * width
                let activeWidth = max(0, endX - startX)
                
                // 2. Calculate the exact position of the current temperature dot
                let dotProgress = CGFloat((currentTemp - minDayTemp) / totalRange)
                let dotX = max(0, min(dotProgress * width, width))
                
                ZStack(alignment: .leading) {
                    // Full-width background track (Gray)
                    Capsule()
                        .fill(Color(.systemGray5))
                        .frame(height: 4)
                    
                    // Active Forecast Range Segment (Gradient)
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.green, .yellow, .orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: activeWidth, height: 4)
                        .offset(x: startX)
                    
                    // Current Temperature Indicator Dot (Circular Thumb with Shadow)
                    Circle()
                        .fill(Color(red: 0.2, green: 0.25, blue: 0.4)) // Dark navy dot
                        .frame(width: 14, height: 14)
                        .overlay {
                            Circle()
                                .stroke(.white, lineWidth: 2) // White border ring
                        }
                        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                        .offset(x: dotX - 7, y: -5) // Centered exactly at dotX (half of width 14)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(width:100, height: 14) // Total structural height bounds for aligning elements
            
            // Right Label: Maximum active temperature
            Text("\(Int(currentMaxTemp))°")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.2, green: 0.25, blue: 0.4))
                .frame(width: 36, alignment: .trailing)
        }
    }
}

#Preview {
    TemperatureRangeIndicatorView(minDayTemp: 1, maxDayTemp: 10, currentMinTemp: 5, currentMaxTemp: 8, currentTemp: 3)
}
