//
//  UIStackView.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import UIKit

extension UIStackView {
    
    func addVerticalSpacer(height: CGFloat? = nil) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        self.addArrangedSubview(spacer)
        if let height = height {
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.setHeight(height)
        }
    }
    
    func addHorizontalSpacer(width: CGFloat? = nil) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        self.addArrangedSubview(spacer)
        spacer.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        if let width = width {
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.setWidth(width)
        }
    }
    
    func clear() {
        for view in self.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
