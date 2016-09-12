//
//  PinterestTransition.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/27.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

let animationDuration = 0.35
let animationScale = kScreenWidth/gridWidth

class PinterestTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var presenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        let containerView = transitionContext.containerView()!
        
        if presenting {
            let toView = toViewController.view!
            containerView.addSubview(toView)
            toView.hidden = true
            
            let waterFallView = (toViewController as! PinterestProtocol).transitionCollectionView()
            let pageView = (fromViewController as! PinterestProtocol).transitionCollectionView()
            waterFallView.layoutIfNeeded()
            let indexPath = pageView.fromPageIndexPath()
            let gridView = waterFallView.cellForItemAtIndexPath(indexPath)
            let leftUpperPoint = gridView!.convertPoint(CGPointZero, toView: toViewController.view)
            
            let snapShot = (gridView as! PinterestWaterfallGridViewProtocol).snapShotForTransition()
            snapShot.transform = CGAffineTransformMakeScale(animationScale, animationScale)
            let pullOffsetY = (fromViewController as! TrainDetailViewController).pageViewCellScrollViewContentOffset().y
            let offsetY : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : kNavigationBarHeight
            snapShot.origin = CGPointMake(0, -pullOffsetY+offsetY)
            containerView.addSubview(snapShot)
            
            toView.hidden = false
            toView.alpha = 0
            toView.transform = snapShot.transform
            toView.frame = CGRectMake(-(leftUpperPoint.x * animationScale),-((leftUpperPoint.y-offsetY) * animationScale+pullOffsetY+offsetY),
                toView.frame.size.width, toView.frame.size.height)
            let whiteViewContainer = UIView(frame: kScreenBounds)
            whiteViewContainer.backgroundColor = UIColor.whiteColor()
            containerView.addSubview(snapShot)
            containerView.insertSubview(whiteViewContainer, belowSubview: toView)
            
            UIView.animateWithDuration(animationDuration, animations: {
                snapShot.transform = CGAffineTransformIdentity
                snapShot.frame = CGRectMake(leftUpperPoint.x, leftUpperPoint.y, snapShot.frame.size.width, snapShot.frame.size.height)
                toView.transform = CGAffineTransformIdentity
                toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
                toView.alpha = 1
                }, completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        whiteViewContainer.removeFromSuperview()
                        transitionContext.completeTransition(true)
                    }
            })
        } else {
            let fromView = fromViewController.view
            let toView = toViewController.view
            
            let waterFallView : UICollectionView = (fromViewController as! PinterestProtocol).transitionCollectionView()
            let pageView : UICollectionView = (toViewController as! PinterestProtocol).transitionCollectionView()
            
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
            
            let indexPath = waterFallView.toIndexPath()
            let gridView = waterFallView.cellForItemAtIndexPath(indexPath)
            
            let leftUpperPoint = gridView!.convertPoint(CGPointZero, toView: nil)
            pageView.hidden = true
            pageView.scrollToItemAtIndexPath(indexPath, atScrollPosition:.CenteredHorizontally, animated: false)
            
            let offsetY : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : kNavigationBarHeight
            let offsetStatuBar : CGFloat = fromViewController.navigationController!.navigationBarHidden ? 0.0 : 20.0;
            let snapShot = (gridView as! PinterestWaterfallGridViewProtocol).snapShotForTransition()
            containerView.addSubview(snapShot)
            snapShot.origin = leftUpperPoint
            UIView.animateWithDuration(animationDuration, animations: {
                snapShot.transform = CGAffineTransformMakeScale(animationScale,
                    animationScale)
                snapShot.frame = CGRectMake(0, offsetY, snapShot.frame.size.width, snapShot.frame.size.height)
                
                fromView.alpha = 0
                fromView.transform = snapShot.transform
                fromView.frame = CGRectMake(-(leftUpperPoint.x)*animationScale,
                    -(leftUpperPoint.y-offsetStatuBar)*animationScale+offsetStatuBar,
                    fromView.frame.size.width,
                    fromView.frame.size.height)
                },completion:{finished in
                    if finished {
                        snapShot.removeFromSuperview()
                        pageView.hidden = false
                        fromView.transform = CGAffineTransformIdentity
                        transitionContext.completeTransition(true)
                    }
            })
        }
    }
}
