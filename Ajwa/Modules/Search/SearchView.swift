    //
    //  SearchView.swift
    //  Ajwa
    //
    //  Created by Moaz on 09/06/2026.
    //

    import SwiftUI

    struct SearchView: View {
        @Environment(\.dismiss) private var dismiss
        
        @StateObject private var viewModel = SearchViewModel(
        repo: SearchRepositiory(searchRemoteDataSource: SearchRemoteDataSource(weatherService: WeatherApiService()
                  )
        )
        )
        var body: some View {
            ZStack {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                VStack {
                    CustomSearchBar(text: $viewModel.searchQuery)
                        .padding()
                        .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)

                    Spacer()
                    ScrollView {
                    VStack {
                        
                        switch viewModel.state {
                            
                        case .idle:
                            EmptyStateView(
                                icon: "magnifyingglass",
                                title: "Search for a city",
                                message: "Enter a city name to find weather information"
                            )
                            
                        case .loading:
                            ProgressView()
                                .frame(
                                    maxWidth: .infinity,
                                    minHeight: UIScreen.main.bounds.height * 0.5
                                )
                            
                        case .success:
                            if viewModel.results.isEmpty {
                                EmptyStateView(
                                    icon: "location.slash",
                                    title: "No cities found",
                                    message: "Try searching with another city name"
                                )
                            } else {
                                ForEach(viewModel.results) { city in
                                    NavigationLink {
                                        DetailsView(city: city)
                                    } label: {
                                        CityWeatherSearchView(city: city)
                                    }
                                }
                            }
                            
                            
                        case .empty:
                            EmptyStateView(
                                icon: "location.slash",
                                title: "No cities found",
                                message: "Try searching with another city name"
                            )
                            
                        case .noInternet:
                            EmptyStateView(
                                icon: "wifi.slash",
                                title: "No Internet Connection",
                                message: "Please check your connection and try again"
                            )
                            
                        case .error:
                            EmptyStateView(
                                icon: "exclamationmark.triangle",
                                title: "Something went wrong",
                                message: "Please try again later"
                            )
                        }
                    }
                    .padding()
                    }  
                    .scrollIndicators(.hidden)
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("AddCity")
                                .foregroundStyle(.primary)
                        }
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)
                    }
                }
            }

        }
    }


    #Preview {
        SearchView()
    }


struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
            
            Text(message)
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.5)
    }
}
