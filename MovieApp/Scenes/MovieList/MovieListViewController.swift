//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import UIKit

class MovieListViewController: UIViewController, Presenter {
    
    internal var viewModel: MovieListViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel = MovieListViewModel(prensenterVc: self)
        
        setupCollectionView()
        view.addSubview(wrapperImageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchMovieList()
    }
        
    // MARK: - Collection view
    lazy private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    internal let leftRightPadding: CGFloat = 10
    internal let interItemSpacing: CGFloat = 10
    internal let lineSpacing: CGFloat = 10
    internal let widthHeightRatio: CGFloat = 1.5
    internal var defaultCellSize: CGSize = .zero
    
    private func setupCollectionView() {
        view.addSubviews(views: collectionView)
        collectionView.fillSuperview()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: leftRightPadding,
                                                   bottom: 0,
                                                   right: leftRightPadding)
        
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)
        
        let width = (view.frame.width - (leftRightPadding*2) - interItemSpacing) / 2
        defaultCellSize = CGSize(width: width, height: width * widthHeightRatio)
    }
    
    // MARK: - Animation
    lazy private var wrapperImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = true
        imgView.setCornerRadius(radius: 4)
        return imgView
    }()
    
    func zoomIntoIndexPath(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell else {
            return
        }
        
        let scale = UIScreen.main.bounds.width / (cell.frame.width)
        let pos = cell.convert(CGPoint.zero, to: nil)

        wrapperImageView.frame = CGRect(x: pos.x,
                               y: pos.y,
                               width: defaultCellSize.width,
                               height: defaultCellSize.height)
        
        wrapperImageView.image = cell.getMovieImage()
                
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            self.view.frame = CGRect(x: -pos.x * scale,
                                     y: -pos.y * scale,
                                     width:  self.view.frame.size.width,
                                     height:  self.view.frame.size.height)
            self.collectionView.layer.opacity = 0
         },completion:{finished in
             if finished {
                 debugPrint("Zoom in done")
                 
                 let vc = MovieDetailViewController(movieImage: self.wrapperImageView.image) {
                     self.collectionView.fadeInAsync(duration: 0)
                     self.zoomOut()
                 }
                 
                 vc.modalPresentationStyle = .overFullScreen
                 self.presentAsync(vc: vc, animated: false)
             }
         })
    }
    
    @MainActor
    func zoomOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.transform = CGAffineTransform.identity
            self.view.frame = CGRect(x: 0,
                                     y: 0,
                                     width:  self.view.frame.size.width,
                                     height:  self.view.frame.size.height)
            self.collectionView.layer.opacity = 1
        },completion:{finished in
            if finished {
                debugPrint("Zoom out done")
            }
        })
    }
    
    // MARK: - Presenting data & loading
    func presentData() {
        collectionView.reloadAsync()
    }
    
    func presentLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}
