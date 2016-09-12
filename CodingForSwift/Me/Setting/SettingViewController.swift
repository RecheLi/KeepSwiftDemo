//
//  SettingViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController ,UITableViewDataSource, UITableViewDelegate {
    var tableView:UITableView!
    let settingCell = "settingCell"
    var items = [["个人资料","隐私设置","连接「健康」"],["健身目标","健身基础","训练设置","音乐管理"],["消息推送","缓存管理","扫一扫"],["关于","邀请好友","帮助与反馈"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.view.backgroundColor = UIColor.whiteColor()
        self.setLeftItemImageNamed(kBackImage)
        self.setupTableView()
    }

    func setupTableView() {
        let tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.registerClass(SettingCell.classForCoder(), forCellReuseIdentifier: settingCell)
        tableView.tableFooterView = UIView()
        self.tableView = tableView
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = items[indexPath.section].count * 44
        return CGFloat(height)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(settingCell, forIndexPath: indexPath) as! SettingCell

        cell.configContainer(items[indexPath.section])
        cell.closure = {(button)->() in
            print(button.titleLabel?.text)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
