//
//  DiscoverTestViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class DiscoverTestViewController: BaseViewController, UINavigationControllerDelegate {
    var headButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "按钮过度"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        headButton = UIButton.init(type: .Custom)
        headButton.frame = CGRectMake(100, 100, 100, 100)
        headButton.tag = 999
        self.view.backgroundColor = UIColor.blueColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push {
            return DiscoverTransition()
        }
        return nil
    }
}
