//
//  DIscoveryViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import YYKit

class DiscoveryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    let discoveryCellIdentifier = "DiscoveryCellIdentifier"
    var links = ["https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
        
        // animated gif: http://cinemagraphs.com/
        "http://i.imgur.com/uoBwCLj.gif",
        "http://i.imgur.com/8KHKhxI.gif",
        "http://i.imgur.com/WXJaqof.gif",
        
        // animated gif: https://dribbble.com/markpear
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
        
        // animaged gif: https://dribbble.com/jonadinges
        "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
        "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
        "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
        "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
        
        // jpg: https://dribbble.com/snootyfox
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
        "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
        
        // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
        "http://littlesvr.ca/apng/images/BladeRunner.png",
        "http://littlesvr.ca/apng/images/Contact.webp",
];
    var discoveryTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Discovery"
        self.view.backgroundColor = UIColor.whiteColor()
        let tableview = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-49), style: UITableViewStyle.Plain)
        tableview.dataSource = self
        tableview.delegate = self

        tableview.registerClass(DiscoveryCell.classForCoder(), forCellReuseIdentifier: discoveryCellIdentifier)
        self.discoveryTableView = tableview
        self.view.addSubview(self.discoveryTableView)
        discoveryTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { () -> Void in
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.discoveryTableView.mj_header.endRefreshing();
            }
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count * 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(discoveryCellIdentifier) as! DiscoveryCell
        cell.setImageUrl(NSURL(string: links[indexPath.row % links.count])!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kScreenWidth*3.0/4.0;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = DiscoveryDetailViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let color = UIColor(colorLiteralRed: 69/255.0, green: 60/255.0, blue: 76/255.0, alpha: 1)
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 0 {
            self.navigationController?.navigationBar.setCoverViewBackgroudColor(color.colorWithAlphaComponent(1))
        } else {
            let alpha = min(1, (64 - offsetY) / 64)
            self.navigationController?.navigationBar.setCoverViewBackgroudColor(color.colorWithAlphaComponent(alpha))
        }
        
        let viewHeight = scrollView.height + scrollView.contentInset.top
        for cell:UITableViewCell in self.discoveryTableView.visibleCells {
            let y = cell.centerY - scrollView.contentOffset.y;
            let p = y - viewHeight / 2;
            let scale = cos(p / viewHeight * 0.8) * 0.95;
            UIView.animateKeyframesWithDuration(0.15, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                let disCoveryCell =  cell as! DiscoveryCell
                disCoveryCell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
            }, completion: nil)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
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
