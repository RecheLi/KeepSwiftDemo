//
//  TrainHistoryViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class TrainHistoryViewController: BaseViewController {
    var logoView: LogoAnimatedView!
    var gradientLabel: GradientLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        gradientLabel = GradientLabel.init(frame: CGRectMake(100, 100, 200, 30))
        gradientLabel.font = UIFont.systemFontOfSize(14)
        gradientLabel.text = "This is Gradientlabel"
        gradientLabel.textColor = UIColor.blackColor()
        gradientLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(gradientLabel)
        gradientLabel.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
