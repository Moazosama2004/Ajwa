//
//  HomeViewModel.swift
//  Ajwa
//
//  Created by Moaz on 09/06/2026.
//


import Foundation
import CoreLocation
import UIKit

@MainActor
class HomeViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showPermissionAlert = false
    @Published var locationDeniedMessage: String? = nil

    private var repo: HomeRepoProtocol?
    private let locationService = LocationService()

    init() {
        setupHandlers()
    }

    func setup(repo: HomeRepoProtocol) {
        guard self.repo == nil else { return }
        self.repo = repo
    }

    private func setupHandlers() {
        locationService.onPermissionDenied = { [weak self] in
            Task { @MainActor in
                self?.showPermissionAlert = true
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.getUserLocation()
        }
    }

    private func loadWeather() async {
        guard let repo else {
            errorMessage = "Repository not initialized"
            return
        }
        isLoading = true
        defer { isLoading = false }
        do {
            let location = try await locationService.requestLocation()
            weather = try await repo.fetchWeatherData(from: location)  
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func getUserLocation() {
        let status = locationService.currentStatus()
        switch status {
        case .notDetermined:
            Task {
                _ = try? await locationService.requestLocation()
            }
        case .denied, .restricted:
            showPermissionAlert = true
        case .authorizedWhenInUse, .authorizedAlways:
            Task { await loadWeather() }
        @unknown default:
            break
        }
    }

    func checkPermissionStatus() {
        let status = locationService.currentStatus()
        showPermissionAlert = status == .denied || status == .restricted
    }

    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
