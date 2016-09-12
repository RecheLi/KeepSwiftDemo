//
//  ProfileHeader.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/18.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {
    var backgroundImgView:UIImageView!
    var profileImageView:UIImageView!
    var fansButton:UIButton!
    var focusButton:UIButton!
    var userNameLabel:UILabel!
    var fansButtonCallback:(()->())?
    var focusButtonCallback:(()->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kDefaultColor
        self._initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initViews() {
        self.backgroundImgView = UIImageView(image: UIImage(named: "banner3.jpg"))
        self.backgroundImgView.frame = self.bounds
        self.backgroundImgView.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(backgroundImgView)
        
        self.profileImageView = UIImageView(image: UIImage(named: "curry"))
        self.profileImageView.frame = CGRectMake((kScreenWidth-70)/2.0, 30, 70, 70)
        self.addSubview(profileImageView)
        
        self.userNameLabel = UILabel()
        self.userNameLabel.textAlignment = .Center
        self.userNameLabel.size = CGSizeMake(kScreenWidth, 16)
        self.userNameLabel.origin = CGPointMake(0, profileImageView.bottom+10)
        self.userNameLabel.text = "这是一个人名"
        self.userNameLabel.textColor = UIColor.whiteColor()
        self.userNameLabel.shadowColor = UIColor.grayColor()
        self.userNameLabel.font = UIFont.systemFontOfSize(13)
        self.addSubview(self.userNameLabel)
        
        let spacing:CGFloat = 0.0
        let buttonWidth:CGFloat = 60.0
        self.fansButton = UIButton(type: .Custom)
        self.fansButton.frame = CGRectMake(kScreenWidth/2.0-buttonWidth-spacing, CGRectGetMaxY(userNameLabel.frame)+10, buttonWidth, 30)
        self.fansButton.setTitle("粉丝", forState: .Normal)
        self.fansButton.showsTouchWhenHighlighted = true
        self.fansButton.titleLabel?.font = UIFont.systemFontOfSize(13);
        self.fansButton.addTarget(self, action: #selector(ProfileHeader.fansButtonClick), forControlEvents: .TouchUpInside)
        self.addSubview(self.fansButton)
        
        self.focusButton = UIButton(type: .Custom)
        self.focusButton.frame = CGRectMake(kScreenWidth/2.0+spacing, CGRectGetMaxY(userNameLabel.frame)+10, buttonWidth, 30)
        self.focusButton.setTitle("关注", forState: .Normal)
        self.focusButton.showsTouchWhenHighlighted = true
        self.focusButton.titleLabel?.font = UIFont.systemFontOfSize(13);
        self.focusButton.addTarget(self, action: #selector(ProfileHeader.focusButtonClick), forControlEvents: .TouchUpInside)
        self.addSubview(self.focusButton)
    }
    
    func fansButtonClick() {
        if fansButtonCallback != nil {
            fansButtonCallback!()
        }
    }
    
    func focusButtonClick() {
        if focusButtonCallback != nil {
            focusButtonCallback!()
        }
    }
    
    func refreshPosition(scrollView:UIScrollView) {
        let scale = fabs(scrollView.contentOffset.y/self.height)
        self.backgroundImgView.layer.position = CGPointMake(kScreenWidth/2.0, (scrollView.contentOffset.y+self.height)/2)
        self.profileImageView.layer.position = CGPointMake(kScreenWidth/2.0, (scrollView.contentOffset.y+130)/2)
        self.userNameLabel.layer.position = CGPointMake(kScreenWidth/2.0, (scrollView.contentOffset.y+118*2)/2)
        self.fansButton.layer.position = CGPointMake(self.fansButton.layer.position.x, (scrollView.contentOffset.y+151*2)/2)
        self.focusButton.layer.position = CGPointMake(self.focusButton.layer.position.x, (scrollView.contentOffset.y+151*2)/2)
        self.backgroundImgView.transform = CGAffineTransformMakeScale(1+scale, 1+scale)
    }
    
    class func test() {
        
    }


}
