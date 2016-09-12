//
//  GradientLabel.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class GradientLabel: UILabel {
    var gradientLayer: CAGradientLayer!
    
    func start() {
        self.stop()
        let leftColor = UIColor.init(white: 1, alpha: 0.6).CGColor
        let midColor = UIColor.whiteColor().CGColor
        let rightColor = UIColor.init(white: 1, alpha: 0.6).CGColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [leftColor,midColor,rightColor]
        gradientLayer.startPoint = CGPointMake(-0.1, 0.5)
        gradientLayer.endPoint = CGPointMake(1+0.1, 0.5)
        let locations = [NSNumber.init(float: 0.0) , NSNumber.init(float: 0.05), NSNumber.init(float: 0.1)];
        gradientLayer.locations = locations
        self.gradientLayer = gradientLayer
        self.layer.addSublayer(self.gradientLayer)
        let animation = CABasicAnimation.init(keyPath: "locations")
        animation.repeatCount = HUGE
        animation.duration = 2.0
        animation.fromValue = [0.0,0.05,0.1]
        animation.toValue = [1-0,1,1-0.05,1.0]
        self.gradientLayer.addAnimation(animation, forKey: nil)
    }
    
    func stop() {
        if (self.gradientLayer != nil) {
            self.gradientLayer.removeAllAnimations()
            self.gradientLayer = nil
        }
    }
}
