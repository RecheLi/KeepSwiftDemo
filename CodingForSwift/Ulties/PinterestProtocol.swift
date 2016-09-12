//
//  PinterestProtocol.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/27.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PinterestProtocol {
    func transitionCollectionView() -> UICollectionView!
}

@objc protocol PinterestWaterfallGridViewProtocol{
    func snapShotForTransition() -> UIView!
}

@objc protocol TrainingViewControllerProtocol : PinterestProtocol{
    func viewWillAppearWithPageIndex(pageIndex : NSInteger)
}

@objc protocol TrainingDetailViewControllerProtocol : PinterestProtocol{
    func pageViewCellScrollViewContentOffset() -> CGPoint
}