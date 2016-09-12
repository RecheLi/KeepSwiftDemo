//
//  AnimatedLabel.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class AnimatedLabel: UILabel {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        let minScale:NSValue = NSValue.init(CATransform3D: CATransform3DMakeScale(0.75, 0.75, 1))
        let maxScale = NSValue.init(CATransform3D: CATransform3DIdentity)
        animation.values = [maxScale,minScale,maxScale]
        animation.fillMode = kCAFillModeBackwards
        animation.duration = 3.0
        animation.repeatCount = HUGE
        self.layer.addAnimation(animation, forKey: "animation")
    }

}
