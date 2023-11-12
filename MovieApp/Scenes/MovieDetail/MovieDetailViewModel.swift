//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import Foundation
import Combine

class MovieDetailViewModel: NetworkableFetcher {
    
    // MARK: - Required Init properties
    var presenter: Presenter
    
    init(prensenterVc: Presenter) {
        presenter = prensenterVc
    }
    
    func getMovieDetails() -> Codable? {
        return dataContainer.first
    }
    
    func fetchMovieDetails(_ movieId: Int) {
        
        let movieDetailRequest: AnyPublisher<MovieDetailResponse, Error> = fetch(path: "movie/".appending(movieId.description), method: .get)
        
        movieDetailRequest.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { err in
                switch err {
                case .finished:
                    debugPrint("fetch MovieList Done")
                case .failure(let er):
                    debugPrint("fetch MovieList \(er)")
                }
            }, receiveValue: { res in

                self.dataContainer.append(res)
                self.presenter.presentData()

            })
            .store(in: &subscriptions)
    }
}
