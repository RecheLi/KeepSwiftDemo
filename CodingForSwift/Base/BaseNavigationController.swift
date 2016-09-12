//
//  BaseNavigationController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage.init(color: UIColor(colorLiteralRed: 69/255.0, green: 60/255.0, blue: 76/255.0, alpha: 1)), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()

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

}
