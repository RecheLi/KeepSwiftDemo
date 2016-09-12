//
//  TrainDetailViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

let trainingDetailCellIdentify = "TrainingDetailCellIdentify"
class TrainDetailViewController: UICollectionViewController, PinterestProtocol, TrainingDetailViewControllerProtocol {
    var pullOffset = CGPointZero
    var imageNameList : Array <NSString> = []
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath){
        super.init(collectionViewLayout:layout)
        let collectionView :UICollectionView = self.collectionView!;
        collectionView.pagingEnabled = true
        collectionView.registerClass(TrainingDetailCell.self, forCellWithReuseIdentifier: trainingDetailCellIdentify)
        collectionView.setToIndexPath(indexPath)
        collectionView.performBatchUpdates({collectionView.reloadData()}, completion: { finished in
            if finished {
                collectionView.scrollToItemAtIndexPath(indexPath,atScrollPosition:.CenteredHorizontally, animated: false)
            }});
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Training Detail"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imageNameList.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let collectionCell: TrainingDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier(trainingDetailCellIdentify, forIndexPath: indexPath) as! TrainingDetailCell
        collectionCell.imageName = self.imageNameList[indexPath.row] as String
        collectionCell.tappedAction = {}

        collectionCell.setNeedsLayout()
        return collectionCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func transitionCollectionView() -> UICollectionView! {
        return self.collectionView
    }
    
    func pageViewCellScrollViewContentOffset() -> CGPoint {
        return self.pullOffset
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


