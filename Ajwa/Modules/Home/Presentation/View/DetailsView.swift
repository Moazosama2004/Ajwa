//
//  DetailsView.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.modelContext) private var modelContext
    let city: WeatherSearchResult
 
    @StateObject private var viewModel = DetailsViewModel()
 
    var body: some View {
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
                    VStack(spacing: 16) {
                        DetailHeroView(weather: weather)
                        HourlyForecastView(hours: weather.forecast.forecastday[0].hour)
                        DaysForecastView(days: weather.forecast.forecastday)
                        PreciptionView(weather: weather)
                        ConditionsView(weather: weather)
                        VisibilityView(weather: weather)
                        UVIndexView(weather: weather)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Favorites action
                } label: {
                    Image(systemName: "heart")
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
                }
        .task {
            await viewModel.loadWeather(from: city)
        }
    }
}

// MARK: - Hero Section

//
//  DetailHeroView.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//
import SwiftUI

// MARK: - Hero Section

struct DetailHeroView: View {

    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 6) {
            Image(WeatherAsset.from(
                code: weather.current.condition.code,
                isDay: weather.current.isDay == 1
            ).rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)

            Text(weather.current.condition.text)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Text(formattedDate(from: weather.location.localtime))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Current temp
            Text("\(Int(weather.current.tempC))°")
                .font(.system(size: 56, weight: .thin))
                .foregroundStyle(.primary)

            // Max / Min
            HStack(spacing: 16) {
                Label(
                    "H: \(Int(weather.forecast.forecastday[0].day.maxtempC))°",
                    systemImage: "arrow.up"
                )
                Label(
                    "L: \(Int(weather.forecast.forecastday[0].day.mintempC))°",
                    systemImage: "arrow.down"
                )
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }

    private func formattedDate(from localtime: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: localtime) else { return localtime }
        let output = DateFormatter()
        output.dateFormat = "EEEE, d MMMM yyyy"
        return output.string(from: date)
    }
}

// MARK: - Alert Banner

struct DetailAlertBannerView: View {

    let message: String

    var body: some View {
        HStack {
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(1)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DetailsView(city: WeatherSearchResult.mock)
    }
}
