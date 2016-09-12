//
//  BaseViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

let gridWidth : CGFloat = (kScreenWidth/2)-5.0
let kScreenBounds = UIScreen.mainScreen().bounds
let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height
let kNavigationBarHeight:CGFloat = 64.0
let kBackImage = "back"
let kDefaultColor = UIColor(colorLiteralRed: 69/255.0, green: 60/255.0, blue: 76/255.0, alpha: 1)
class BaseViewController: UIViewController {

    var leftItem:UIButton!
    var rightItem:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setLeftItemTitle(title:String, action:Selector) {
        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(17)];
        let size = title.sizeWithAttributes(attributes)
        leftItem = UIButton(type: UIButtonType.Custom)
        leftItem.frame = CGRectMake(0, 0, size.width<=10 ? 70 : size.width+10, 44)
        leftItem.setTitle(title, forState: UIControlState.Normal)
        leftItem.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        leftItem.titleLabel?.font = UIFont.systemFontOfSize(17)
        leftItem.titleLabel?.textAlignment = NSTextAlignment.Left
        
        let negativerSpacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        weak var weakself = self
        leftItem.addBlockForControlEvents(UIControlEvents.TouchUpInside) { (Selector) -> Void in
            weakself?.performSelector(action)
        }
        let item = UIBarButtonItem.init(customView: leftItem)
        self.navigationItem.leftBarButtonItems = [negativerSpacer, item]
    }
    
    func setRightItemImageNamed(name:String) {
        self.setRightItemImageNamed(name, action: nil)
    }
    
    func setRightTitle(name:String, action:Selector) {

    }
    
    func setLeftItemImageNamed(name:String) {
        self.setLeftItemImageNamed(name, action: nil)
    }
    func setLeftItemImageNamed(name:String, action:Selector) {
        let image = UIImage.init(named: name)
        leftItem = UIButton(type: UIButtonType.Custom)
        leftItem.origin = CGPointMake(0, 0)
        leftItem.size = CGSizeMake(24, 24)
        leftItem.setImage(image, forState: UIControlState.Normal)
        leftItem.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        if (name=="back"||action==nil) {
            weak var weakself = self
            leftItem .addBlockForControlEvents(UIControlEvents.TouchUpInside, block: { (Selector) -> Void in
                weakself?.navigationController?.popViewControllerAnimated(true)
            })
        }
        leftItem.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5)
        let item = UIBarButtonItem.init(customView: leftItem)
        self.navigationItem.leftBarButtonItem = item

    }
    
    func setRightItemImageNamed(name:String, action:Selector) {
        let image = UIImage.init(named: name)
        rightItem = UIButton(type: UIButtonType.Custom)
        rightItem.origin = CGPointMake(0, 0)
        rightItem.size = CGSizeMake(50, 44);
        rightItem.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 0, -10)
        rightItem.setImage(image, forState: UIControlState.Normal)
        rightItem.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        let item = UIBarButtonItem.init(customView: rightItem)
        self.navigationItem.rightBarButtonItem = item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        print("\(self) deinit")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
