//
//  UVIndexSlider.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct UVIndexIndicatorView: View {
    let uvValue: Double
    let maxUVIndex: Double = 11.0
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                let width = geometry.size.width
                let percentage = CGFloat(uvValue / maxUVIndex)
                let thumbPosition = max(0, min(percentage * width, width))
                
                ZStack(alignment: .leading) {
                    // Custom Linear Gradient Track
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.green, .yellow, .orange, .red, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 4)
                    
                    // Static Visual Thumb (No gestures attached)
                    VStack(spacing: 2) {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 24))
                        
                        Image(systemName: "triangle.fill")
                            .font(.system(size: 8))
                            .foregroundStyle(.orange)
                            .rotationEffect(.degrees(180)) // Points down at the track
                    }
                    // Align the thumb center point directly over the calculated position coordinate
                    .offset(x: thumbPosition - 12, y: -16)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(height: 40)
            
            // 2. Bottom Label Text Layer
            HStack {
                Text("Low")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("Extreme danger")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.primary)
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    UVIndexIndicatorView(uvValue: 5.0)
}
