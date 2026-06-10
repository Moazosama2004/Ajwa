//
//  SearchViewModel.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var results: [WeatherSearchResult] = []
    @Published var isLoading = false
    
    private let repo: SearchRepositiory
    private var cancellables = Set<AnyCancellable>()
    
    init(repo: SearchRepositiory) {
        self.repo = repo
        setupSearch()
    }
    
    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                Task {
                    await self?.performSearch(query: value)
                }
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) async {
        guard !query.isEmpty else {
            results = []
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let data = try await repo.search(for: query)
            results = data
        } catch {
            print("Search error:", error)
            results = []
        }
    }
}
