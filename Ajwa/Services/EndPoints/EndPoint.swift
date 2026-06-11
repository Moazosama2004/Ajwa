//
//  EndPoint.swift
//  Ajwa
//
//  Created by Moaz on 11/06/2026.
//

import Foundation

protocol EndPoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
}
