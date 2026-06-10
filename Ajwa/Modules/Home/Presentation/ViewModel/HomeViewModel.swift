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
    
    private let repo: HomeRepository
    private let locationService = LocationService()

    init(repo: HomeRepository) {
        self.repo = repo
        setupHandlers()
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
            Task {
                await loadWeather()
            }

        @unknown default:
            break
        }
    }
    
    func checkPermissionStatus() {
        let status = locationService.currentStatus()

        if status == .denied || status == .restricted {
            showPermissionAlert = true
        } else {
            showPermissionAlert = false
        }
    }

    private func loadWeather() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let location = try await locationService.requestLocation()
            weather = try await repo.fetchForecast(from: location)

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Open Settings
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
