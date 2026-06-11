//
//  NetworkBanner.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import SwiftUI

struct NetworkBanner: View {
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        if !networkMonitor.isConnected {
            HStack {
                Image(systemName: "wifi.slash")
                
                Text("No Internet Connection")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.red)
            .transition(.move(edge: .top))
        }
    }
}
#Preview {
    NetworkBanner()
}
