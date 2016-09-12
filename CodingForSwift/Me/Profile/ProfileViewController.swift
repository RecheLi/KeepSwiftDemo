//
//  ProfileViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    var profileTable:UITableView!
    var profileHeader:ProfileHeader!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资料"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        self.creatProfileTable()
        self.configHeaderView()
    }
    
    func creatProfileTable() {
        let tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight), style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        profileTable = tableView
        self.view.addSubview(profileTable)

    }
    
    func configHeaderView() {
        let header:ProfileHeader = ProfileHeader(frame: CGRectMake(0,0,kScreenWidth,211));
        header.backgroundColor = kDefaultColor
        self.profileHeader = header
        profileTable.tableHeaderView = header
        print(profileHeader.fansButton.layer.position)
        weak var weakself = self
        profileHeader.fansButtonCallback = { () -> () in
            print("fansButtonCallback")
            weakself?.hidesBottomBarWhenPushed = true
            let vc = FansTableViewController()
            weakself?.navigationController?.pushViewController(vc, animated: true)
        }
        
        profileHeader.focusButtonCallback = { () -> () in
            print("focusButtonCallback")
        }
    }
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.font = UIFont.systemFontOfSize(13)
        cell?.textLabel?.text = "动态：第\(indexPath.row+1)天天气不错"
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let menuView = ProfileMenu(frame: CGRectMake(0,0,kScreenWidth,44))
        menuView.menuClosure = {(idx)->() in
            switch idx {
                case 0:
                    print("动态")
                    break
                case 1:
                    print("照片")
                    break
                case 2:
                    print("记录")
                    break
                default:
                    break
            }
        }
        return menuView
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            profileHeader.refreshPosition(scrollView);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
