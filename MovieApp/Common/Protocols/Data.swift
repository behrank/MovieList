//
//  Data.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import Foundation
import Combine

protocol DataFetcher {
    var baseUrl: String { get }
    func fetch<T: Codable>(path: String, method: HTTPMethod) -> AnyPublisher<T, Error>
}

