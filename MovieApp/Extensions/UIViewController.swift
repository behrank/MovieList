//
//  UIViewController.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import UIKit

extension UIViewController {
    
    func presentAsync(vc: UIViewController, animated: Bool) {
        Queue.main.execute {
            self.present(vc, animated: animated)
        }
    }
}
