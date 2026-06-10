//
//  CityWeatherSearchView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//

import SwiftUI

struct CityWeatherSearchView: View {
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24 , height: 24)
                    .padding(.leading ,8)
                
                VStack(alignment: .leading) {
                    Text("Kreuzberg")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.primary)
                    
                  
                    
                    Text("Berlin, Germany")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.secondary)

                }
                
            }
            Spacer()
            Image(systemName: "apple.logo")
                .resizable()
                .scaledToFit()
                .frame(width: 40 , height: 40)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(LinearGradient(colors: [.white , .white], startPoint: .bottomLeading, endPoint: .topTrailing))
           
            
        }
    }
}

#Preview {
    CityWeatherSearchView()
}
