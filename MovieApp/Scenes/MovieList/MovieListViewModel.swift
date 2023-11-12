//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import Foundation
import Combine

class MovieListViewModel: PagedNetworkableFetcher {
    
    // MARK: - Required Init properties
    var presenter: Presenter
    
    init(prensenterVc: Presenter) {
        presenter = prensenterVc
    }
    
    // MARK: - Public funcs
    func getTotalResultCount() -> Int {
        return dataContainer.count
    }
    
    func getItemForIndexPath(_ indexPath: IndexPath) -> Codable? {
        return dataContainer[indexPath.row]
    }
    
    func fetchMovieList() {
        
        let movieFetchRequest: AnyPublisher<MovieListResponse, Error> = fetch(path: "discover/movie", method: .get)
        
        movieFetchRequest.receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { err in
            switch err {
            case .finished:
                debugPrint("fetch MovieList Done")
            case .failure(let er):
                debugPrint("fetch MovieList \(er)")
            }
        }, receiveValue: { res in
            
            self.totalPages = res.totalPages
            self.totalResults = res.totalResults
            self.pageNumber = res.page
            
            if let movieInfo = res.results {
                self.dataContainer.append(contentsOf: movieInfo)
            }
            
            self.presenter.hideLoading()
            self.presenter.presentData()

        })
        .store(in: &subscriptions)
    }
}
