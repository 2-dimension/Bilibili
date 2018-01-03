//
//  UIViewExtension.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/8/29.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import UIKit

extension UIView
{
    
    /// Traverse all subviews including self.
    @objc public func traverseSubviews(_ callback: (UIView) -> Void) {
        callback(self)
        print("\(subviews)")
        for subview in subviews {
            subview.traverseSubviews(callback)
        }
    }
    
}
