//
//  WeatherLocalStorageService.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import SwiftData

final class WeatherLocalStorageService: WeatherLocalStorageServiceProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func saveMyLocation(_ response: WeatherResponse) {
        deleteAll(MyLocationWeather.self)
        context.insert(WeatherModelMapper.toMyLocation(from: response))
        persist()
    }

    func fetchMyLocation() -> MyLocationWeather? {
        fetch(MyLocationWeather.self).first
    }

    func addFavourite(_ response: WeatherResponse) {
        guard !isFavourite(cityName: response.location.name) else { return }
        context.insert(WeatherModelMapper.toFavourite(from: response))
        persist()
    }

    func removeFavourite(cityName: String) {
        fetch(FavouriteLocationWeather.self)
            .filter { $0.cityName == cityName }
            .forEach { context.delete($0) }
        persist()
    }

    func fetchAllFavourites() -> [FavouriteLocationWeather] {
        let descriptor = FetchDescriptor<FavouriteLocationWeather>()
        return (try? context.fetch(descriptor)) ?? []
    }

    func isFavourite(cityName: String) -> Bool {
        fetchAllFavourites().contains { $0.cityName == cityName }
    }
}

private extension WeatherLocalStorageService {

    func fetch<T: PersistentModel>(_ type: T.Type) -> [T] {
        (try? context.fetch(FetchDescriptor<T>())) ?? []
    }

    func deleteAll<T: PersistentModel>(_ type: T.Type) -> Void {
        fetch(type).forEach { context.delete($0) }
    }

    func persist() {
        try? context.save()
    }
}
