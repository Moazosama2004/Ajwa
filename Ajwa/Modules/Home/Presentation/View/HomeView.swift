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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                    
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                } else if let weather = viewModel.weather {
                    
                    ScrollView {
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(1..<5) { _ in
                                    MainWeatherView(weather: weather)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
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
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Favorites tapped")
                    } label: {
                        Image(systemName: "heart")
                            .foregroundStyle(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.primary)
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
            
            // MARK: - Permission Alert
            .alert("Location Permission Required",
                   isPresented: $viewModel.showPermissionAlert) {
                
                Button("Open Settings") {
                    viewModel.openSettings()
                }

                Button("Retry") {
                    viewModel.getUserLocation()
                }

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
