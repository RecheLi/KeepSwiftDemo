//
//  SettingCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

typealias sendButtonClosure = (button:UIButton) -> Void

class SettingCell: UITableViewCell {
    var model:NSObject!
    var container:UIView!
    var rowHeight:CGFloat = 44.0
    var buttonSpacing:CGFloat = 8.0
    var datasource = [String]();
    var closure:sendButtonClosure?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.container = UIView(frame: CGRectMake(10,10,kScreenWidth-20,rowHeight))
        self.container.layer.cornerRadius = 10.0;
        self.container.layer.masksToBounds = true
        self.container.layer.shouldRasterize = true
        self.container.layer.borderWidth = 0.2
        self.container.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.container.backgroundColor = UIColor(red: 224/255.0, green: 231/255.0, blue: 235/255.0, alpha: 0.6)
        self.contentView.addSubview(self.container)
    }

    override func layoutSubviews() {
        
    }
    
    func configContainer(data:[String]) {
        self.container.removeAllSubviews()
        self.container.layer.sublayers = nil
        self.container.height = CGFloat(data.count) * rowHeight - 10;
        for var index = 0; index < data.count; index++  {
            let button = UIButton(type: .Custom)
            button.origin = CGPointMake(buttonSpacing, CGFloat(CGFloat(index)*self.container.height/CGFloat(data.count)))
            button.size = CGSizeMake(kScreenWidth-buttonSpacing*2, CGFloat(self.container.height/CGFloat(data.count)))
            button.setTitle(data[index], forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
            button.addTarget(self, action: Selector("menuButtonClick:"), forControlEvents: .TouchUpInside)
            self.container.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    func handleDatasource (data:NSArray) {
 
    }
    
    func menuButtonClick(sender:UIButton) {
        if closure != nil {
            closure!(button: sender)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
