//
//  UIView.swift
//  RacoonKit
//
// The MIT License (MIT)

// Copyright (c) 2019 Can Behran Kankul

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

// MARK: Adding & Removing
extension UIView {

    /// RK: Adds views to superview
    /// - Parameter radius: CGFloat- Parameter views: UIView and its subclasses
    public func addSubviews(views: UIView...) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
    
    /// RK: Removes subviews of superview
    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    public func fadeOutAsync(duration: CGFloat = 0.2) {
        Queue.main.execute {
            UIView.animate(withDuration: duration) {
                self.layer.opacity = 0
            }
        }
    }
    
    public func fadeInAsync(duration: CGFloat = 0.2) {
        Queue.main.execute {
            UIView.animate(withDuration: duration) {
                self.layer.opacity = 1
            }
        }
    }
}