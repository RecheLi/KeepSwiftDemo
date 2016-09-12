//
//  FansCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

typealias fansCellClosure = (index:Int)->Void

class FansCell: UITableViewCell {
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var headImageView: UIImageView!

    var focusClosure: fansCellClosure?
    override func awakeFromNib() {
        super.awakeFromNib()
        headImageView.layer.borderWidth = 0.5
        headImageView.layer.borderColor = UIColor(hexString: "666666")?.CGColor
        headImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        headImageView.layer.masksToBounds = true

        focusButton.layer.borderWidth = 0.5
        focusButton.layer.borderColor = UIColor(hexString: "1ccc80")?.CGColor
        focusButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        focusButton.layer.masksToBounds = true
    }

    @IBAction func focus(sender: UIButton) {
        if focusClosure != nil {
            focusClosure!(index: sender.tag)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
