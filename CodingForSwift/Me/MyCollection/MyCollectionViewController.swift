//
//  MyCollectionViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class MyCollectionViewController: BaseViewController {
    var emitterLayer: CAEmitterLayer!
    var praiseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        self.navigationItem.title = "我的收藏"
        self.setPraiseButton()
        self.setup()
        // Do any additional setup after loading the view.
    }
    
    func setPraiseButton() {
        let button = UIButton(type: .Custom)
        button.center = CGPointMake(self.view.centerX,self.view.centerY-64)
        button.size = CGSizeMake(32, 28)
        button.setImage(UIImage(named: "praise_on"), forState: .Normal)
        button.addTarget(self, action: #selector(MyCollectionViewController.praise(_:)), forControlEvents: .TouchUpInside)
        self.praiseButton = button
        self.view.addSubview(self.praiseButton)
        
    }
    
    func setup() {
        let emitterCell = CAEmitterCell()
        emitterCell.name = "emitterCell"
        emitterCell.alphaRange     = 0.10;
        emitterCell.alphaSpeed     = -1.0;
        emitterCell.lifetime       = 5;
        emitterCell.lifetimeRange  = 1.3;
        emitterCell.birthRate      = 48;
        emitterCell.velocity       = 40.00;
        emitterCell.velocityRange  = 1000.00;
        emitterCell.scale          = 1;
        emitterCell.scaleRange     = 0.5;
        emitterCell.contents = UIImage(named: "u_center_collect")?.CGImage
        
        emitterLayer = CAEmitterLayer()
        emitterLayer.name = "emitterLayer"
        emitterLayer.emitterCells = [emitterCell]
        emitterLayer.renderMode = "oldestFirst"
        emitterLayer.emitterMode = "outline"
        emitterLayer.emitterShape = "circle"
        emitterLayer.masksToBounds = false;
        emitterLayer.position = CGPointMake(self.praiseButton.width/2, self.praiseButton.height/2);
        self.praiseButton.layer.addSublayer(emitterLayer)
        emitterLayer.beginTime = CACurrentMediaTime()

    }
    
    func praise(sender:UIButton) {
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.setValue(30, forKeyPath:"emitterCells.emitterCell.birthRate" )
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
