//
//  StringExtension.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/14.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import Foundation

extension String {
    func logString() {
        NSLog(self)
    }
}

var indexPathKey = "indexPathKey"
extension UICollectionView {
    //    http://stackoverflow.com/questions/24021291/import-extension-file-in-swift

    func setToIndexPath(indexPath: NSIndexPath) {
        objc_setAssociatedObject(self, &indexPathKey, indexPath, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func toIndexPath() -> NSIndexPath {
        let index = self.contentOffset.x/self.frame.width
        if index > 0 {
            return NSIndexPath(forRow: Int(index), inSection: 0)
        } else if let indexPath = objc_getAssociatedObject(self, &indexPathKey) as? NSIndexPath {
            return indexPath
        } else {
            return NSIndexPath(forRow: 0, inSection: 0)
        }
    }
    
    func fromPageIndexPath () -> NSIndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return NSIndexPath(forRow: index, inSection: 0)
    }
}