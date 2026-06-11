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
    @Published var state: SearchState = .idle
    
    private let repo: SearchRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repo: SearchRepositoryProtocol) {
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
    
    func clearSearch() {
        searchQuery = ""
        results = []
        state = .idle
    }
    
    private func performSearch(query: String) async {
        
        guard !query.isEmpty else {
            results = []
            state = .idle
            return
        }
        
        state = .loading
        
        do {
            let data = try await repo.search(for: query)
            
            results = data
            
            if data.isEmpty {
                state = .empty
            } else {
                state = .success
            }
            
        } catch {
            
            if let urlError = error as? URLError,
               urlError.code == .notConnectedToInternet {
                
                state = .noInternet
                
            } else {
                state = .error
            }
            
            results = []
            
            print(error)
        }
    }
}


enum SearchState {
    case idle
    case loading
    case success
    case empty
    case noInternet
    case error
}
