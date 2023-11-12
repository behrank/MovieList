//
//  Font.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import Foundation

enum FontType {
    case black
    case blackItalic
    case bold
    case boldItalic
    case italic
    case medium
    case mediumItalic
    case regular
    case light
    case lightItalic
    case thin
    case thinItalic
    
    var fontName: String {
        switch self {
        case .black:        return "Roboto-Black"
        case .blackItalic:  return "Roboto-BlackItalic"
        case .bold:         return "Roboto-Bold"
        case .boldItalic:   return "Roboto-BoldItalic"
        case .medium:       return "Roboto-Medium"
        case .mediumItalic: return "Roboto-MediumItalic"
        case .regular:      return "Roboto-Regular"
        case .light:        return "Roboto-Light"
        case .lightItalic:  return "Roboto-LightItalic"
        case .thin:         return "Roboto-Thin"
        case .thinItalic:   return "Roboto-ThinItalic"
        case .italic:       return "Roboto-Italic"
        }
    }
}
