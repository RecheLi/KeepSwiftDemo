//
//  DiscoveryDetailViewController.swift
//  CodingForSwift
//  
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class DiscoveryDetailViewController: BaseViewController {
    var headButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        headButton = UIButton.init(type: .Custom)
        headButton.frame = CGRectMake(100, 100, 100, 100)
        headButton.tag = 999
        headButton.setImage(UIImage.init(named: "3.jpg"), forState: .Normal)
        headButton.addTarget(self, action: #selector(DiscoveryDetailViewController.clickHeadButton), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(headButton)
        
    }

    func clickHeadButton() {
        let vc = DiscoverTestViewController()
        self.navigationController?.delegate = vc
        self.navigationController?.pushViewController(vc, animated: true)
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
