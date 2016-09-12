//
//  PlayerViewController.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit

class PlayerViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource {
    let playerCellIdentifier = "PlayerCellIdentifier"

    @IBOutlet weak var tableView: UITableView!
    var playerView: LTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视频播放"
        self.setLeftItemImageNamed(kBackImage)
        self.tableView.rowHeight = 200
        self.tableView.registerNib(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: playerCellIdentifier)
        playerView = LTPlayerView.init(frame: CGRectMake(0, 0, kScreenWidth, 200), url: "http://baobab.wdjcdn.com/14564977406580.mp4")
        self.tableView.addSubview(playerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(playerCellIdentifier) as! PlayerCell

        return cell
    }
    
    
    // MARK: deinit
    deinit {

    }

}
