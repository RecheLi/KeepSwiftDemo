 //
//  AppDelegate.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var allowRotation: Bool!
    var window: UIWindow?
    var tabarController: RootViewController!
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        allowRotation = false
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        tabarController = RootViewController();
        self.window?.rootViewController = tabarController;
        UINavigationBar.appearance().barTintColor = kDefaultColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red: 70/255.0, green: 61/155.0, blue: 78/255.0, alpha: 1)], forState: UIControlState.Selected)
        self.window?.makeKeyAndVisible();
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotation == true {
            return UIInterfaceOrientationMask.LandscapeRight
        }
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    
    func getAppdelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}

