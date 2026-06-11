//
//  SearchRemoteDataSourceProtocol.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

protocol SearchRemoteDataSourceProtocol {
    func search(for query: String) async throws -> [WeatherSearchResult]
}
