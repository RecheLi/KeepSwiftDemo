//
//  MeCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {
    var model: MeModel!
    @IBOutlet weak var desctiptLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = imgView.width/2.0
        imgView.layer.masksToBounds = true
        imgView.layer.shouldRasterize = true
        imgView.layer.rasterizationScale = UIScreen.mainScreen().scale
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
