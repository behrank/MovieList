//
//  SkeletonCollectionViewCell.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import UIKit
import Kingfisher

class SkeletonCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "SkeletonCollectionViewCell"
    
    func setupCell() {
        contentView.setCornerRadius(radius: 4)
        contentView.backgroundColor = .tertiarySystemBackground
        
        contentView.startShimmeringAnimation()
    }
}
