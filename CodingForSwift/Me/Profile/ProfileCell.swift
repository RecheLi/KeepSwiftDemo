//
//  ProfileCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import YYKit

class ProfileCell: UITableViewCell {
    var momentView:MomentView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class MomentView: UIView {
    var headImageView:UIImageView!
    var nameLabel:YYLabel!
    var addressLabel:YYLabel!
    var timeLabel:YYLabel!
    var contentLabel:YYLabel!
    var menuView:MenuView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not implementioned")
    }
}



class MenuView: UIView {
    var praiseButton:UIButton!
    var commentButton:UIButton!
    var shareButton:UIButton!
    var moreButton:UIButton!
    var menuClosure:((buttonIndex:Int)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not implementioned")
    }
}