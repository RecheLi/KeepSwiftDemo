//
//  MeViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit



class MeViewController: BaseViewController ,UITableViewDataSource, UITableViewDelegate{
    var tableView:UITableView!
    let meCellId = "MeCellIdentifier"
    let profileCellId = "MyProfileCellIdentifier"
    var items = [[""],["GradientLabel","训练等级","呼吸灯"],["EmitterLayer"],["个人资料"],["视频播放器"]]
    var images = [[""],["me_icon_history","u_center_grade","u_center_badge"],["u_center_collect"],["u_center_personal"],["me_icon_history"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我";
        self.view.backgroundColor = UIColor.whiteColor()
        self.setRightItemImageNamed("install", action:#selector(MeViewController.installAction))
        self.setupTableView()
        self.getData()
        
    }
    
    func installAction() {
        self.hidesBottomBarWhenPushed = true
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    func getData() {
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight-49), style: UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 224/255.0, green: 231/255.0, blue: 235/255.0, alpha: 0.8)
        tableView.registerNib(UINib(nibName: "MeCell", bundle: nil), forCellReuseIdentifier: meCellId)
        tableView.registerNib(UINib(nibName: "MyProfileCell", bundle: nil), forCellReuseIdentifier: profileCellId)
        tableView.tableFooterView = UIView()
        self.tableView = tableView
        self.view.addSubview(self.tableView)
    }
    
    let completionBlock:(NSData,NSError)->Void
            = { data, error in
                NSLog("%@", data);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section==0 && indexPath.row==0 {
            return 100.0
        }
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let count:Int = items[section].count where items[section].count > 0 else {
            print("no datas")
            return 0
        }
        return count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==0 && indexPath.row==0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(profileCellId) as! MyProfileCell
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(meCellId) as! MeCell
        cell.imgView.image = UIImage(named: images[indexPath.section][indexPath.row])
        cell.desctiptLabel.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.hidesBottomBarWhenPushed = true
        switch (indexPath.section) {
            case 0:
                let vc = ProfileViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                switch (indexPath.row) {
                    case 0:
                        let vc = TrainHistoryViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 1:
                        let vc = TrainLevelViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 2:
                        let vc = MyBadgeViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    default:
                        break
                }
                break
            case 2:
                let myCollectionVC = MyCollectionViewController()
                self.navigationController?.pushViewController(myCollectionVC, animated: true)
                break
            case 3:
                let profileVC = ProfileViewController()
                self.navigationController?.pushViewController(profileVC, animated: true)
                break
        case 4:
            let playerVC = PlayerViewController()
            self.navigationController?.pushViewController(playerVC, animated: true)
            break
            default:
                break
        }
        self.hidesBottomBarWhenPushed = false;
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
