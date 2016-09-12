//
//  LightningView.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import SnapKit

class LightningView: UIView {
    var textField: UITextField!
    var deleteButton: UIButton!
    var animatedLayer: CAShapeLayer!
    var startLocation: CGPoint!
    var viewTagLeft: CGFloat!
    var lightningView: LightningView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.addPangesture()
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("has no impletion this method")
    }
    
    func addPangesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(LightningView.panLightningView(_:)))
        self.addGestureRecognizer(pan)
    }
    
    func setup () {
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(35, 0))
        bezierPath.addLineToPoint(CGPointMake(25, 15))
        bezierPath.addLineToPoint(CGPointMake(35, 30))
        bezierPath.addLineToPoint(CGPointMake(35, 30))
        bezierPath.addLineToPoint(CGPointMake(50, 30))
        bezierPath.addLineToPoint(CGPointMake(50, 0))
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.path = bezierPath.CGPath
        layer.fillColor = UIColor(white: 0.1, alpha: 1).CGColor
        self.layer.addSublayer(layer)
        
        textField = UITextField(frame: CGRectMake(45, 0, 60, 30))
        textField.layer.cornerRadius = 4.0
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1)
        textField.textColor = UIColor.whiteColor()
        textField.borderStyle = .None
        textField.text = "美女";
        self.addSubview(textField)
        
        deleteButton = UIButton(type: .Custom)
        deleteButton.origin = CGPointMake(textField.right, 0)
        deleteButton.size = CGSizeMake(30, 30)
        deleteButton.layer.cornerRadius = 4.0
        deleteButton.backgroundColor = UIColor(white: 0.1, alpha: 1)
        self.addSubview(deleteButton)
        
        let staticLayer = CAShapeLayer()
        staticLayer.origin = CGPointMake(12, 12)
        staticLayer.backgroundColor = UIColor.whiteColor().CGColor
        staticLayer.size = CGSizeMake(6, 6)
        staticLayer.cornerRadius = staticLayer.width/2.0
        staticLayer.masksToBounds = true
        staticLayer.rasterizationScale = UIScreen.mainScreen().scale
        
        animatedLayer = CAShapeLayer()
        animatedLayer.origin = CGPointMake(5, 5)
        animatedLayer.backgroundColor = UIColor.blackColor().CGColor
        animatedLayer.size = CGSizeMake(20, 20)
        animatedLayer.cornerRadius = animatedLayer.width/2.0
        animatedLayer.masksToBounds = true
        animatedLayer.rasterizationScale = UIScreen.mainScreen().scale
        self.layer.addSublayer(animatedLayer)
        self.layer.addSublayer(staticLayer)
        self.startAnimation()
    }
    
    func panLightningView(pan:UIPanGestureRecognizer) {
        lightningView = pan.view as! LightningView
        let point = pan.locationInView(lightningView.superview)
        if (pan.state == .Began) {
            viewTagLeft = point.x-lightningView.origin.x;
        }
       self.panTagViewPoint(point)
        
    }
    
    func panTagViewPoint(point:CGPoint) -> Void {
        NSLog("%@",NSStringFromCGPoint(point));
        lightningView.snp_updateConstraints { (make) in
            make.left.equalTo(point.x-viewTagLeft)
            make.top.equalTo(point.y-15)
            if((point.x-viewTagLeft)<=0){
                make.left.equalTo(0);
            }
            if (point.y+15 >= lightningView.superview?.height) {
                make.top.equalTo((lightningView.superview?.height)!-50);
            }
            if (point.y-15 <= 0) {
                make.top.equalTo(0);
            }
            if (point.x+(lightningView.width-viewTagLeft) >= kScreenWidth) {
                make.left.equalTo(kScreenWidth-lightningView.width);
            }
        }
    }
    
    func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        let minScale:NSValue = NSValue.init(CATransform3D: CATransform3DMakeScale(0.75, 0.75, 1))
        let maxScale = NSValue.init(CATransform3D: CATransform3DMakeScale(1.25, 1.25, 1))
        animation.values = [maxScale,minScale,maxScale]
        animation.fillMode = kCAFillModeBackwards
        animation.duration = 2.0
        animation.repeatCount = HUGE
        animatedLayer.addAnimation(animation, forKey: "animation")
        
    }
    
    func stopAnimation() {
        
    }
    

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
