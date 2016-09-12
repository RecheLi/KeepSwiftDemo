//
//  CalendarViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class CalendarViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "日历学习"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
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
