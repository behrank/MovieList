//
//  MovieListViewController+Collectionview.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import UIKit

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoadingShimmerActive {
            return 6
        }
        return viewModel?.getTotalResultCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isLoadingShimmerActive {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkeletonCollectionViewCell.reuseId,
                                                                for: indexPath) as? SkeletonCollectionViewCell else {
                return UICollectionViewCell(frame: .zero)
            }
            cell.setupCell()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId,
                                                                for: indexPath) as? MovieCollectionViewCell,
                  let data = viewModel?.getItemForIndexPath(indexPath) as? MovieInfo else {
                return UICollectionViewCell(frame: .zero)
            }
            
            cell.setupCellWithMovieInfo(data)
            return cell
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        zoomIntoIndexPath(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel?.checkNextPageRequired(index: indexPath.row)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return defaultCellSize
    }
}
