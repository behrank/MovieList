//
//  LoadingView.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import UIKit

class LoadingView: UIView {
    
    lazy private var loadingLbl: AppLabel = {
        return AppLabel(text: "loading".uppercased(),
                        font: .medium, size: 12)
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubviews(views: loadingLbl)
        loadingLbl.fillSuperview()
        loadingLbl.textAlignment = .center
        
        backgroundColor = UIColor.purple
        setCornerRadius(radius: 12)
    }
}
