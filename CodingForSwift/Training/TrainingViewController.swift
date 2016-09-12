//
//  TraningViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrainingViewController: BaseViewController, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,TrainingViewControllerProtocol,PinterestProtocol {
    var bounceView: UIView!
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var trainCollectionView:UICollectionView!
    var items:NSMutableArray! = ["训练历史","训练等级","我的徽章","我的收藏","个人资料","训练历史","训练等级","我的徽章","我的收藏","个人资料","训练历史","训练等级","我的徽章","我的收藏","个人资料","训练历史","训练等级","我的徽章","我的收藏","个人资料"]
    var imageNameList : Array <NSString> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Keeping";
        self.createCollectionView();
        self.createBounceView()
        self.getData()
    
    }
    
    func getData() {
        var index = 0
        while(index<14){
            let imageName = NSString(format: "%d.jpg", index)
            imageNameList.append(imageName)
            index += 1
        }
        self.trainCollectionView.reloadData()
    }

    func configDynamicBehavior() {
        if animator != nil {
            animator.removeAllBehaviors()
        }
        gravityBehavior = UIGravityBehavior(items: [self.bounceView])
        gravityBehavior.magnitude = 6.0
        animator.addBehavior(gravityBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [self.bounceView])
        collisionBehavior.addBoundaryWithIdentifier("collisionBoundary", fromPoint: CGPointMake(0, kScreenHeight+2), toPoint: CGPointMake(kScreenWidth, kScreenHeight+2))
        animator.addBehavior(collisionBehavior)

        itemBehavior = UIDynamicItemBehavior(items: [self.bounceView])
        itemBehavior.elasticity = 0.4
        animator.addBehavior(itemBehavior)
    }
    
    func createBounceView() {
        bounceView = UIImageView(image: UIImage(named: "launchImage"))
        bounceView.origin = CGPointMake(0, -kScreenHeight)
        bounceView.size = CGSizeMake(kScreenWidth, kScreenHeight)
        bounceView.userInteractionEnabled = true;
        let pan = UIPanGestureRecognizer(target: self, action: #selector(TrainingViewController.panBounceView(_:)))
        bounceView.addGestureRecognizer(pan)
        UIApplication.sharedApplication().keyWindow!.addSubview(bounceView)
        animator = UIDynamicAnimator(referenceView: (UIApplication.sharedApplication().keyWindow!))
    }
    
    func panBounceView(aPan:UIPanGestureRecognizer) {
        let offset:CGPoint = aPan.translationInView(self.view)
        if bounceView.centerY + offset.y > kScreenHeight/2.0 {
            return;
        }
        if aPan.state == .Changed {
            bounceView.center = CGPointMake((self.navigationController?.view.centerX)!, bounceView.centerY + offset.y)
            aPan.setTranslation(CGPointMake(0,0), inView: self.view)
        } else if aPan.state == .Ended {
            if ( bounceView.center.y + offset.y<0) {
                UIView.animateWithDuration(0.34, animations: { () -> Void in
                    self.bounceView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
                })
                return;
            }
            self.configDynamicBehavior()
        }
    }
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 224/255.0, green: 231/255.0, blue: 235/255.0, alpha: 0.9)
        collectionView.registerNib(UINib(nibName: "TrainingCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.trainCollectionView = collectionView;
        self.view.addSubview(self.trainCollectionView)
        
        trainCollectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { () -> Void in
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.trainCollectionView.mj_header.endRefreshing();
                self.configDynamicBehavior()

            }
        })
        
        trainCollectionView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { () -> Void in
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            self.items.addObjectsFromArray(self.items as [AnyObject]);
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.trainCollectionView.reloadData();
                self.trainCollectionView.mj_footer.endRefreshing();
            }
        })

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameList.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TrainingCell
        cell.imgView.image = UIImage(named: self.imageNameList[indexPath.row] as String)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = TrainDetailViewController(collectionViewLayout:pageViewControllerLayout() , currentIndexPath: indexPath);
        vc.imageNameList = imageNameList
        self.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 0, 10)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((kScreenWidth-30)/2, 147/113*(kScreenWidth-30)/2)

    }
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        var position : UICollectionViewScrollPosition =
        UICollectionViewScrollPosition.CenteredHorizontally.intersect(.CenteredVertically)
        let image:UIImage! = UIImage(named: self.imageNameList[pageIndex] as String)
        let imageHeight = image.size.height*gridWidth/image.size.width
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
            position = .Top
        }
        let currentIndexPath = NSIndexPath(forRow: pageIndex, inSection: 0)
        let collectionView = self.trainCollectionView!;
        collectionView.setToIndexPath(currentIndexPath)
        if pageIndex<2{
            collectionView.setContentOffset(CGPointZero, animated: false)
        }else{
            collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: position, animated: false)
        }
    }
    
    func transitionCollectionView() -> UICollectionView! {
        return self.trainCollectionView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewControllerLayout () -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = self.navigationController!.navigationBarHidden ?
            CGSizeMake(kScreenWidth, kScreenHeight+20) : CGSizeMake(kScreenWidth, kScreenHeight-kNavigationBarHeight)
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        return flowLayout
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
