//
//  LogoAnimatedView.swift
//  CodingForSwift
//
//  Created by Apple on 16/8/16.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
let kAnimationDuration: NSTimeInterval = 3.0
let kAnimationDurationDelay: NSTimeInterval = 0.5
let kRippleMagnitudeMultiplier: CGFloat = 0.025
let fblueColor = UIColor(red: 15/255, green: 78/255, blue: 101/255, alpha: 1)



class LogoAnimatedView: UIView {
    private let radius: CGFloat = 37.5
    private let squareLayerLength: CGFloat = 21.0
    private let startTimeOffset = 0.7 * kAnimationDuration
    private let strokeEndTimingFunction   = CAMediaTimingFunction(controlPoints: 1.00, 0.0, 0.35, 1.0)
    private let squareLayerTimingFunction      = CAMediaTimingFunction(controlPoints: 0.25, 0.0, 0.20, 1.0)
    private let circleLayerTimingFunction   = CAMediaTimingFunction(controlPoints: 0.65, 0.0, 0.40, 1.0)
    private let fadeInSquareTimingFunction = CAMediaTimingFunction(controlPoints: 0.15, 0, 0.85, 1.0)

    var circleLayer: CAShapeLayer!
    var lineLayer: CAShapeLayer!
    var squareLayer: CAShapeLayer!
    var maskLayer: CAShapeLayer!
    var circelAnimation: CAKeyframeAnimation!
    var lineAnimation:  CABasicAnimation!
    var squareAnimation: CABasicAnimation!
    var beginTime: CFTimeInterval = 0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() -> Void {
        circleLayer = CAShapeLayer()
        circleLayer.lineWidth = radius
        circleLayer.strokeColor = UIColor.clearColor().CGColor
        circleLayer.fillColor = UIColor.whiteColor().CGColor
        circleLayer.path = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(3*M_PI_2), clockwise: true).CGPath
        self.layer.addSublayer(circleLayer)
        
        lineLayer = CAShapeLayer()
        lineLayer.position = CGPointZero
        lineLayer.frame = CGRectZero
        lineLayer.allowsGroupOpacity = true
        lineLayer.lineWidth = 5.0
        lineLayer.strokeColor = fblueColor.CGColor
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(self.center)
        bezierPath.addLineToPoint(CGPointMake(self.centerX, self.centerY-radius))
        lineLayer.path = bezierPath.CGPath
        self.layer.addSublayer(lineLayer)

        squareLayer = CAShapeLayer()
        squareLayer.position = CGPointZero
        squareLayer.frame = CGRectMake(self.center.x-squareLayerLength/2.0, self.center.y-squareLayerLength/2.0, squareLayerLength, squareLayerLength)
        squareLayer.cornerRadius = 1.5
        squareLayer.allowsGroupOpacity = true
        squareLayer.backgroundColor = fblueColor.CGColor
        self.layer.addSublayer(squareLayer)
        self.startAnimation()
    }
    
    func startAnimation() {
        beginTime = CACurrentMediaTime()
        layer.anchorPoint = CGPointZero
        circelAnimation = CAKeyframeAnimation.init(keyPath: "strokeEnd")
        circelAnimation.timingFunction = strokeEndTimingFunction
        circelAnimation.duration = kAnimationDuration - kAnimationDurationDelay
        circelAnimation.values = [0, 1,0]
        circelAnimation.keyTimes = [0, 1.0]

        let transformAnimation = CABasicAnimation.init(keyPath: "transform")
        transformAnimation.timingFunction = strokeEndTimingFunction
        transformAnimation.duration = kAnimationDuration - kAnimationDurationDelay
        var startingTransform = CATransform3DMakeRotation(-CGFloat(M_PI_4), 0, 0, 1)
        startingTransform = CATransform3DScale(startingTransform, 0.25, 0.25, 1)
        transformAnimation.fromValue = NSValue(CATransform3D: startingTransform)
        transformAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [circelAnimation, transformAnimation];
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.beginTime = beginTime
        groupAnimation.timeOffset = startTimeOffset
        circleLayer.addAnimation(groupAnimation, forKey: "looping")
        
    }
}
