//
//  TrainingDetailCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/27.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import Foundation
import UIKit

let cellIdentify = "cellIdentify"
class DescriptCell : UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFontOfSize(13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageView :UIImageView = self.imageView!;
        if (imageView.image != nil) {
            let imageHeight = imageView.image!.size.height*kScreenWidth/imageView.image!.size.width
            imageView.frame = CGRectMake(0, 0, kScreenWidth, imageHeight)
        }
    }
}

class TrainingDetailCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    var imageName : String?
    var pullAction : ((offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: kScreenBounds, style: UITableViewStyle.Plain)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        
        contentView.addSubview(tableView)
        tableView.registerClass(DescriptCell.self, forCellReuseIdentifier: cellIdentify)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as! DescriptCell!
        cell.imageView?.image = nil
        cell.textLabel?.text = nil
        if indexPath.row == 0 {
            let image = UIImage(named: imageName!)
            cell.imageView?.image = image
        }else{
            cell.textLabel?.text = "😃 😃 😃 😃 😃"
        }
        cell.setNeedsLayout()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var cellHeight : CGFloat = kNavigationBarHeight
        if indexPath.row == 0{
            let image:UIImage! = UIImage(named: imageName!)
            let imageHeight = image.size.height*kScreenWidth/image.size.width
            cellHeight = imageHeight
        }
        return cellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(scrollView : UIScrollView){
        if scrollView.contentOffset.y < kNavigationBarHeight{
            pullAction?(offset: scrollView.contentOffset)
        }
    }

}
