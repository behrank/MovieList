//
//  ViewModel.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import Foundation
import Combine

class NetworkableFetcher: DataFetcher {
    
    var baseUrl: String = "https://api.themoviedb.org/3/"
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private let headers = ["accept": "application/json"]
    
    internal var subscriptions = Set<AnyCancellable>()
    internal var dataContainer: [Codable] = []
    
    func fetch<T>(path: String, method: HTTPMethod) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        
        var url = URL(string: baseUrl.appending(path))!
                
        url.withQuery(["api_key": apiKey])
        
        var request = URLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
                
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                debugPrint(String(bytes: element.data, encoding: .utf8) ?? "")
                return element.data
                
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class PagedNetworkableFetcher: NetworkableFetcher {
    internal var pageNumber: Int?   = 0
    internal var totalPages: Int?   = 0
    internal var totalResults: Int? = 0
}
