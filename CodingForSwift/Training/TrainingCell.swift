//
//  TrainingCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/25.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class TrainingCell: UICollectionViewCell, PinterestWaterfallGridViewProtocol {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imgView.clipsToBounds = true
        // Initialization code
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imgView.image)
        snapShotView.frame = imgView.frame
        return snapShotView
    }
    

}
