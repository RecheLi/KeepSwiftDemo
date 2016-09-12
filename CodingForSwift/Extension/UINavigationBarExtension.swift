//
//  UINavigationBarExtension.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/16.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import Foundation

var key: String = "coverView"

extension UINavigationBar {
    var coverView: UIView? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setCoverViewBackgroudColor(color: UIColor) {
        if (self.coverView == nil) {
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRectMake(0, -20, UIScreen.mainScreen().bounds.size.width, CGRectGetHeight(self.bounds) + 20))
            view.userInteractionEnabled = false
            view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            self.insertSubview(view, atIndex: 0)
            
            view.backgroundColor = color
            self.coverView = view
            return;
        }
        self.coverView!.backgroundColor = color
    }
}