//
//  AppLabel.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import UIKit

class AppLabel: UILabel {
    
    init(text: String, font: FontType, 
         size: CGFloat = 14,
         color: UIColor = .label,
         isMultiline: Bool = true) {
        
        super.init(frame: .zero)
        
        self.text = text
        self.numberOfLines = isMultiline ? 0 : 1
        self.font = UIFont(name: font.fontName, size: size)
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
