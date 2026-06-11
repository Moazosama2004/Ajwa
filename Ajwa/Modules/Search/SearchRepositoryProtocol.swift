//
//  SearchRepositoryProtocol.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

protocol SearchRepositoryProtocol {
    func search(for query: String) async throws -> [WeatherSearchResult]
}
