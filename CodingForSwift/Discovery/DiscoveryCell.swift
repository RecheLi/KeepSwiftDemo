//
//  DiscoveryCell.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import YYKit

let kCellHeight = kScreenWidth*3.0/4.0

class DiscoveryCell: UITableViewCell {
    var webImageView: YYAnimatedImageView!
    var progressLayer: CAShapeLayer!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.size = CGSizeMake(kScreenWidth, kCellHeight)
        self.contentView.size = self.size
        let webImageView = YYAnimatedImageView()
        self.webImageView = webImageView
        self.webImageView.origin = CGPointMake(0, 0)
        self.webImageView.size = self.size;
        self.webImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.webImageView.clipsToBounds = true
        self.contentView.addSubview(self.webImageView)
        
        let lineHeight: CGFloat = 4.0
        let progressLayer = CAShapeLayer()
        progressLayer.origin = CGPointMake(0, 0)
        progressLayer.size = CGSizeMake(self.webImageView.width, lineHeight)
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, progressLayer.height/2.0))
        path.addLineToPoint(CGPointMake(self.webImageView.width, progressLayer.height/2.0))
        progressLayer.lineWidth = lineHeight
        progressLayer.path = path.CGPath
        progressLayer.strokeColor = UIColor.purpleColor().CGColor
        progressLayer.fillColor = UIColor.redColor().CGColor
        progressLayer.lineCap = kCALineCapButt
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        self.progressLayer = progressLayer
        self.webImageView.layer.addSublayer(self.progressLayer)
        
    }
    func setImageUrl(url:NSURL) {
//        self.webImageView.setImageWithURL(url, options: YYWebImageOptions.ProgressiveBlur)
        self.webImageView.setImageWithURL(url, placeholder: UIImage.init(named: "plan320_160"), options: YYWebImageOptions.ProgressiveBlur, progress: { (recievedSize, expectedSize) -> Void in
            var progress = recievedSize / expectedSize
            progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
            self.progressLayer.strokeEnd = CGFloat(progress);

        }, transform: nil) { (image, url, from, stage, error) -> Void in
            self.progressLayer.hidden = true;
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
