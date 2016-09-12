//
//  MyBadgeViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class MyBadgeViewController: BaseViewController {
    var timer: NSTimer!
    var animatiedLabel: AnimatedLabel!
    var imageView: UIImageView!
    var filter: CIFilter!
    var imageContext: CIContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的徽章"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        self.setRightItemImageNamed("plusbtn_on", action: #selector(MyBadgeViewController.addFilter))
        self.setupAnimatedLabel() 
//        self.setupImageView()
    }
    
    func setupImageView() {
        let imageView = UIImageView(image: UIImage(named: "sample.gif"))
        imageView.origin = CGPointMake(0, 70)
        imageView.size = CGSizeMake(kScreenWidth, 211)
        self.imageView = imageView
        self.imageView.contentMode = .ScaleToFill
        self.view.addSubview(self.imageView)
        self.imageView.image = ImageUtil.imageWithImage(self.imageView.image, withColorMatrix: colormatrix_heibai)
    }
    
    func setupAnimatedLabel() {
        let aLabel = AnimatedLabel()
        aLabel.center = CGPointMake(self.view.centerX-25.0, 10)
        aLabel.size = CGSizeMake(50, 50);
        aLabel.layer.cornerRadius = aLabel.width/2
        aLabel.layer.masksToBounds = true
        aLabel.backgroundColor = UIColor(white: 0.8, alpha:0.4)
        self.animatiedLabel = aLabel
        self.view.addSubview(self.animatiedLabel)
    }
    func setupFilter() { // a sample (cpu handle)
        //滤镜名字
//        let filterNames = CIFilter.filterNamesInCategory(kCICategoryBuiltIn)
//        print(filterNames)
//        
//        filter = CIFilter(name: "CIColorMonochrome")
//        let inputImage = CIImage(image: self.imageView.image!)
//        filter.setValue(inputImage, forKey: "inputImage")
//        let eaglContext = EAGLContext(API: .OpenGLES2)
//        imageContext = CIContext(EAGLContext: eaglContext)
//        let outputImage = imageContext.createCGImage(filter.outputImage!, fromRect: (inputImage?.extent)!)
//        let outUIImage = UIImage(CGImage: outputImage)
//        self.imageView.image = outUIImage


    }
    
    func addFilter() {
        self.setupFilter()

    }
    
    func handleFilter() {
        //        let eaglContext = EAGLContext(API: .OpenGLES2)
        //        let ciContext = CIContext(EAGLContext: eaglContext)
//        ciContext.drawImage(filter.outputImage!, inRect:CGRectMake(0, 287, kScreenWidth, 211) , fromRect: (inputImage?.extent)!)
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
