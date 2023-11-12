//
//  ViewController.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 10.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
        
    // MARK: - Collection view
    lazy private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private func setupCollectionView() {
        view.addSubviews(views: collectionView)
        collectionView.fillSuperview()
    }
}

