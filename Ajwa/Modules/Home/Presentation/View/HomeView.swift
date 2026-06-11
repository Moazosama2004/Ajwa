//
//  HomeView.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//
import SwiftUI
import CoreLocation
import SwiftData

struct HomeView: View {

    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HomeViewModel()

    private let theme = ThemeManager.shared.current

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(theme.contentColor)

                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()

                } else if let weather = viewModel.weather {
                    ScrollView {
                        MainWeatherView(weather: weather) 
                        HourlyForecastView(hours: weather.forecast.forecastday[0].hour)
                        DaysForecastView(days: weather.forecast.forecastday)
                        PreciptionView(weather: weather)
                        ConditionsView(weather: weather)
                        VisibilityView(weather: weather)
                        UVIndexView(weather: weather)
                    }
                    .scrollIndicators(.hidden)
                    .padding()
                } else {
                    ProgressView("Getting location...")
                        .tint(theme.contentColor)
                }
            }
            .themedBackground()
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        FavouritesView()
                    } label: {
                        Image(systemName: "heart")
                            .foregroundStyle(theme.contentColor)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(theme.contentColor)
                    }
                }
            }
            .onAppear {
                viewModel.setup(
                    repo: HomeRepository(
                        remoteDataSource: HomeRemoteDataSource(
                            weatherService: WeatherApiService()
                        ),
                        localDataSource: HomeLocalDataSource(
                            localStorageService: WeatherLocalStorageService(context: modelContext)
                        )
                    )
                )
                viewModel.getUserLocation()
            }
            .alert("Location Permission Required",
                   isPresented: $viewModel.showPermissionAlert) {
                Button("Open Settings") { viewModel.openSettings() }
                Button("Retry") { viewModel.getUserLocation() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enable location access in Settings to continue using the app.")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                viewModel.getUserLocation()
            }
        }
    }
}

#Preview {
    HomeView()
}
