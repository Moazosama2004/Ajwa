//
//  PerciptationItemView.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import SwiftUI

struct PerciptationItemView: View {
    let title : String
    let imageIcon : ImageResource
    let percentage : Int
    let color : String
    
    var body: some View {
        HStack(alignment: .top ,spacing: 8.0) {
            Image(imageIcon)
                .resizable()
                .scaledToFit()
                .background {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(Color(hex: color))
                        .frame(width: 28, height: 28)
                }
                .frame(width: 28, height: 28)
            
            
            VStack(alignment: .leading, spacing:4) {
                Text(title)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Text("\(percentage)%")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.primary)
            }
            Spacer()
        }
    }
}

#Preview {
    PerciptationItemView(title: "Cloudy", imageIcon: .humidity, percentage: 88, color: "DffFeda")
}
