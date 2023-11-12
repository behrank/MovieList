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
    var presenter: LoadablePresenter
        
    init(prensenterVc: LoadablePresenter) {
        presenter = prensenterVc
    }
    
    // MARK: - Public funcs
    func getTotalResultCount() -> Int {
        return dataContainer.count
    }
    
    func getItemForIndexPath(_ indexPath: IndexPath) -> Codable? {
        return dataContainer[indexPath.row]
    }
    
    func checkNextPageRequired(index: Int) {
        if dataContainer.count - index == 4 {
            fetchMovieList(shouldFetchNextpage: true)
        }
    }
    
    func fetchMovieList(shouldFetchNextpage: Bool = false) {
        
        if isFetching {
            return
        }
        
        if shouldFetchNextpage {
            pageNumber += 1
        }
        
        presenter.presentLoading()
        
        let movieFetchRequest: AnyPublisher<MovieListResponse, Error> = fetch(path: "discover/movie",
                                                                              method: .get,
                                                                              queryParams: [["page" : pageNumber.description]])
        
        movieFetchRequest.receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { err in
            switch err {
            case .finished:
                debugPrint("fetch MovieList Done")
            case .failure(let er):
                debugPrint("fetch MovieList \(er)")
            }
        }, receiveValue: { res in
            
            self.totalPages = res.totalPages ?? 0
            self.totalResults = res.totalResults ?? 0
            self.pageNumber = res.page ?? 0
            
            if let movieInfo = res.results {
                self.dataContainer.append(contentsOf: movieInfo)
            }
            
            self.presenter.hideLoading()
            self.presenter.presentData()

        })
        .store(in: &subscriptions)
    }
}
