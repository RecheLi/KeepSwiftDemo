//
//  PlayerCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerView: LTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        playerView .setupVideoURL("http://baobab.wdjcdn.com/14564977406580.mp4")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
