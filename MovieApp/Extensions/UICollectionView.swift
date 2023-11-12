//
//  UICollectionView.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 11.11.2023.
//

import UIKit

extension UICollectionView {
    func reloadAsync() {
        Queue.main.execute {
            self.reloadData()
        }
    }
}

