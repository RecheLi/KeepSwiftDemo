//
//  RootViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit


class RootViewController: UITabBarController {
    var trainVC:TrainingViewController!
    var discoveryVC:DiscoveryViewController!
    var meVC:MeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatSubControllers()
        // Do any additional setup after loading the view.
    }

    func creatSubControllers() {
        trainVC = TrainingViewController();
        let trainNav = BaseNavigationController.init(rootViewController: trainVC)
        let trainItem : UITabBarItem = UITabBarItem (title: "训练", image: UIImage(named: "train_on"), selectedImage: UIImage(named: "train_on")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        trainVC.tabBarItem = trainItem;
        
        discoveryVC = DiscoveryViewController();
        let discoveryNav = BaseNavigationController.init(rootViewController: discoveryVC)
        let discoveryItem : UITabBarItem = UITabBarItem (title: "发现", image: UIImage(named: "discovery"), selectedImage: UIImage(named: "discovery_on")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        discoveryVC.tabBarItem = discoveryItem;
        
        meVC = MeViewController();
        let meNav = BaseNavigationController.init(rootViewController: meVC)
        let meItem : UITabBarItem = UITabBarItem (title: "我", image: UIImage(named: "personal"), selectedImage: UIImage(named: "personal_on")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        meVC.tabBarItem = meItem;
        let tabArray = [trainNav,discoveryNav,meNav];
        self.viewControllers = tabArray;
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

}
