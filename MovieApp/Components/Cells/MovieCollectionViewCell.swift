//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MovieCollectionViewCell"
    
    private var movieInfo: MovieInfo?
    
    func setupCellWithMovieInfo(_ data: MovieInfo) {
        movieInfo = data
        setupUI()
        
        guard let movieInfo = movieInfo else {
            return
        }
        
        backgroundImage.kf.setImage(
            with: URL(string: movieInfo.getPosterPath()),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
    
    func getMovieImage() -> UIImage? {
        return backgroundImage.image
    }
    
    // MARK: - UI objects
    lazy private var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.setCornerRadius(radius: 4)
        return imageView
    }()
    
    //MARK: - UI setup
    private func setupUI() {
        contentView.addSubviews(views: backgroundImage)
        backgroundImage.fillSuperview()
    }
    
}
