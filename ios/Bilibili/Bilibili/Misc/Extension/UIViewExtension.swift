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
    public var centerX: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width * 0.5 }
        set { self.frame.origin.x = newValue - self.frame.size.width * 0.5 }
    }
    
    public var centerY: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height * 0.5 }
        set { self.frame.origin.y = newValue - self.frame.size.height * 0.5 }
    }
    
    public var size: CGSize {
        get { return self.frame.size }
        set { self.frame = CGRect(origin: self.frame.origin, size: size) }
    }
}
