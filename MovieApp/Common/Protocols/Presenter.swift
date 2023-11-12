//
//  Presenter.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import Foundation

protocol Loadable {
    
    var loadingView: LoadingView? { get set }
    
    func presentLoading()
    func hideLoading()
}

protocol Presenter {
    
    func presentData()
    
}

protocol LoadablePresenter: Presenter, Loadable {
    
}
