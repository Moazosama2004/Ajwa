//
//  SearchRepositiory.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

class SearchRepositiory : SearchRepositoryProtocol {
    private let searchRemoteDataSource : SearchRemoteDataSource
    
    init(searchRemoteDataSource: SearchRemoteDataSource) {
        self.searchRemoteDataSource = searchRemoteDataSource
    }
    
    func search(for query : String) async throws -> [WeatherSearchResult] {
        try await searchRemoteDataSource.search(for: query)
    }
}
