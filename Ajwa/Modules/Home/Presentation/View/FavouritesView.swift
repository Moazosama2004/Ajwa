import SwiftUI

struct FavouritesView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = FavouritesViewModel()
    private let theme = ThemeManager.shared.current

    @State private var cityToDelete: String? = nil
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .tint(theme.contentColor)

            } else if viewModel.favourites.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "star.slash")
                        .font(.system(size: 50))
                        .foregroundStyle(theme.contentColor.opacity(0.5))

                    Text("No favourites yet")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(theme.contentColor)

                    Text("Add some cities to see them here!")
                        .font(.system(size: 15))
                        .foregroundStyle(theme.contentColor.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.6)

            } else {
                List {
                    ForEach(viewModel.favourites, id: \.location.name) { favourite in
                        NavigationLink {
                            DetailsView(city: viewModel.toSearchResult(favourite))
                        } label: {
                            CityWeatherSearchView(city: viewModel.toSearchResult(favourite))
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                cityToDelete = favourite.location.name
                                showDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
        }
        .themedBackground()
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundStyle(theme.contentColor)
                }
            }
        }
        .alert("Remove Favourite", isPresented: $showDeleteAlert) {
            Button("Remove", role: .destructive) {
                if let city = cityToDelete {
                    viewModel.removeFavourite(cityName: city)
                    cityToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                cityToDelete = nil
            }
        } message: {
            Text("Are you sure you want to remove \(cityToDelete ?? "this city") from your favourites?")
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
            viewModel.fetchAllFavourites()
        }
    }
}

#Preview {
    NavigationStack {
        FavouritesView()
    }
}
