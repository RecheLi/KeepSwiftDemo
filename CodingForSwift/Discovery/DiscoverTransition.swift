//
//  DiscoverTransition.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit


class DiscoverTransition: NSObject,UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.35
    weak var transitionContext: UIViewControllerContextTransitioning?

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DiscoveryDetailViewController
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let containerView = transitionContext.containerView()
        containerView?.addSubview(toView!)
        //做动画处理
        let headButton = fromController.headButton
        let circlepathInitial = UIBezierPath.init(ovalInRect: headButton.frame)
        let extremePoint = CGPointMake(headButton.centerX, headButton.centerY-kScreenHeight)
        let radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y) //平方根
        let circlePathFinal = UIBezierPath.init(ovalInRect: CGRectInset(headButton.frame, -radius, -radius))
        print(extremePoint,radius)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePathFinal.CGPath
        toView?.layer.mask = shapeLayer
        
        let maskAnimation = CABasicAnimation.init(keyPath: "path")
        maskAnimation.fromValue = circlepathInitial.CGPath
        maskAnimation.toValue = circlePathFinal.CGPath
        maskAnimation.duration = self.transitionDuration(transitionContext)
        maskAnimation.delegate = self
        shapeLayer.addAnimation(maskAnimation, forKey: "path")
        
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        //remove the mask at fromViewController
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
