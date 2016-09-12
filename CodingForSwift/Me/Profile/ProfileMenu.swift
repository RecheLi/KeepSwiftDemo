//
//  ProfileMenu.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

typealias ProfileMenuClosure = ((index:Int)->())
enum ProfileMenuType : Int {
    case Moments
    case Photos
    case Records
}

class ProfileMenu: UIView {
    var menuItems = ["动态","照片","记录"]
    var menuClosure:ProfileMenuClosure?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _init() {
        self.backgroundColor = UIColor.whiteColor()
        for var i=0; i<menuItems.count;i++ {
            let button = UIButton(type: .Custom)
            button.tag = i
            button.origin = CGPointMake(kScreenWidth/3*CGFloat(i), 0)
            button.size = CGSizeMake(kScreenWidth/3, self.height)
            button.titleLabel?.font = UIFont.systemFontOfSize(12)
            button.setTitle(menuItems[i], forState: .Normal)
            button.setTitleColor(kDefaultColor, forState: .Normal)
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Selected)
            button.addTarget(self, action: Selector("menuSelect:"), forControlEvents: .TouchUpInside)
            self.addSubview(button)
            
            let seperatorLayer = CAShapeLayer()
            seperatorLayer.origin = CGPointMake(kScreenWidth/3*CGFloat(i+1), 10)
            seperatorLayer.size = CGSizeMake(0.3, self.height-seperatorLayer.origin.y*2)
            seperatorLayer.backgroundColor = UIColor(hexString: "999999")?.CGColor
            self.layer.addSublayer(seperatorLayer)
        }
        
        let lineLayer = CAShapeLayer()
        lineLayer.frame = CGRectMake(0, self.height-0.3, kScreenWidth, 0.3)
        lineLayer.backgroundColor = UIColor(hexString: "999999")?.CGColor
        self.layer.addSublayer(lineLayer)
    }
    
    func menuSelect(sender:UIButton) {
        if menuClosure != nil {
            menuClosure! (index: sender.tag)
        }
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
