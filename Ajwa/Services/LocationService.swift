//
//  LocationService.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    private var continuation: CheckedContinuation<CLLocation, Error>?
    var onPermissionDenied: (() -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() async throws -> CLLocation {

        let status = manager.authorizationStatus

        switch status {

        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
            throw NSError(domain: "Location", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "Waiting for permission"
            ])

        case .denied, .restricted:
            throw NSError(domain: "Location", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Location permission denied"
            ])

        case .authorizedWhenInUse, .authorizedAlways:
            break

        @unknown default:
            break
        }

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation()
        }
    }
    
    func currentStatus() -> CLAuthorizationStatus {
        manager.authorizationStatus
    }

    // MARK: - Authorization change
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {

        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()

        case .denied, .restricted:
            onPermissionDenied?()

        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        @unknown default:
            break
        }
    }

    // MARK: - Success
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        continuation?.resume(returning: location)
        continuation = nil
    }

    // MARK: - Error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
