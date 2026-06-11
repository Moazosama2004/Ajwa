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

                }  else if viewModel.locationDeniedMessage != nil {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Location Disabled")
                            .font(.headline)
                        
                        Text("Enable location from Settings to get weather updates.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        Button("Open Settings") {
                            viewModel.openSettings()
                        }
                        .font(.caption.bold())
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(14)
                    .padding(.horizontal)
                } else {
                    ProgressView("Getting location...")
                        .tint(theme.contentColor)
                }
                
                VStack {
                    NetworkBanner()
                        .shadow(radius: 4)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    Spacer()
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
                            storageService: WeatherLocalStorageService(context:modelContext)
                        )
                    )
                )
                viewModel.getUserLocation()
            }
            .alert("Location Permission Required",
                   isPresented: $viewModel.showPermissionAlert) {
                Button("Open Settings") { viewModel.openSettings() }
                Button("Retry") { viewModel.getUserLocation() }
                Button("Cancel", role: .cancel) {
                    viewModel.showPermissionAlert = false
                    viewModel.locationDeniedMessage = "Location is denied. Please enable it from Settings."
                }
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
