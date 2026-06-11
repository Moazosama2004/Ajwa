//
//  AjwaApp.swift
//  Ajwa
//
//  Created by Moaz on 08/06/2026.
//

import SwiftUI
import SwiftData

@main
struct AjwaApp: App {
    @StateObject private var networkMonitor = NetworkMonitor.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
        }.modelContainer(for: [
            MyLocationWeather.self,
            FavouriteLocationWeather.self,
            ForecastDayEntity.self
        ]).environmentObject(networkMonitor)
    }
}
