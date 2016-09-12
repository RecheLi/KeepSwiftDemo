//
//  TrainLevelViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class TrainLevelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        self.navigationItem.title = "训练等级"
        self.setupImageView();
        self.setupLightningView()
        // Do any additional setup after loading the view.
    }

    func setupImageView() {
        let imagView = UIImageView();
        imagView.origin = CGPointMake(0, 0)
        imagView.size = CGSizeMake(kScreenWidth, kScreenWidth)
        imagView.image = UIImage(named: "placeholder292_292")
        self.view.addSubview(imagView)
    }
    
    func setupLightningView() {
        let lightView = LightningView()
        lightView.origin = CGPointMake(50, 50)
        lightView.size = CGSizeMake(100, 30);
        self.view.addSubview(lightView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
