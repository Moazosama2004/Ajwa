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
                        if viewModel.isLoading {
                            ProgressView()
                        }
                        
                        ForEach(viewModel.results) { city in
                            NavigationLink {
                                DetailsView(city: city)
                            } label: {
                                CityWeatherSearchView(city: city)
                            }

                          
                        }
                    }
                    .padding()
            }  .scrollIndicators(.hidden)
              
              
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
