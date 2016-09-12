//
//  LTPlayerView.swift
//  CodingForSwift
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 Linitial. All rights reserved.
//

import UIKit
import AVFoundation



class LTPlayerView: UIView {
    //http://baobab.wdjcdn.com/14564977406580.mp4
    var playbackTimeObserver: AnyObject?
    var actIndicator: UIActivityIndicatorView!
    var ltPlayer: AVPlayer!
    var ltPlayerItem: AVPlayerItem!
    var ltPlayerLayer: AVPlayerLayer!
    var playButton: UIButton!   //播放
    var screenButton: UIButton! //全屏按钮
    var progressView: UIProgressView! //播放进度条
    var slider: UISlider!   //进度滑杆
    var timeLabel: UILabel! //播放时间与总时间
    var displayLink: CADisplayLink!
   
    private var menuTimer: NSTimer!
    private var isFullScreen: Bool!
    private var showMenuView: Bool!
    private var failLabel: UILabel!
    private var menuView: UIView!
    private var originRect: CGRect!
    private var duration: Float64!
    var _usrString = "http://baobab.wdjcdn.com/14564977406580.mp4"
    var urlString: NSString! {
        get {
            return _usrString
        }
        set (newValue) {
            _usrString = newValue as String
        }
    }

    init(frame: CGRect, url: NSString) {
        super.init(frame: frame)
        self.duration = 0
        self.urlString = url
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.duration = 0
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if ltPlayerLayer != nil {
            ltPlayerLayer.frame = self.bounds
        }
    }
    
    func setup() -> Void {
        originRect = self.frame
        self.backgroundColor = UIColor.blackColor()
        self.setupIndicator()
        self.setupMenuView()
        self.addPlayerGesture()
        self.setupVideoURL(self.urlString)
    }
    
    //loading框
    func setupIndicator() {
        actIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .White)
        self.addSubview(actIndicator)
        actIndicator.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        actIndicator.startAnimating()
    }
    
    func setupMenuView() {
        menuView = UIView()
        menuView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
        self.addSubview(menuView)
        menuView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(44)
        }
        // 播放按钮
        playButton = UIButton.init(type: .Custom)
        menuView.addSubview(playButton)
        playButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-8)
            make.left.equalTo(self).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(28)
        }
        playButton.setImage(UIImage.init(named: "play"), forState: .Normal)
        playButton.setImage(UIImage.init(named: "pause"), forState: .Highlighted)
        playButton.setImage(UIImage.init(named: "pause"), forState: .Selected)
        playButton.addTarget(self, action: #selector(self.playOrPause), forControlEvents: .TouchUpInside)
        
        // 全屏按钮
        screenButton = UIButton.init(type: .Custom)
        menuView.addSubview(screenButton)
        screenButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(23)
            make.width.equalTo(22)
        }
        screenButton.setImage(UIImage.init(named: "fullScreen"), forState: .Normal)
        screenButton.setImage(UIImage.init(named: "notFullScreen"), forState: .Selected)
        screenButton.addTarget(self, action: #selector(self.toFullScreen), forControlEvents: .TouchUpInside)
        
        timeLabel = UILabel()
        timeLabel.text = "00:00"
        timeLabel.font = UIFont.systemFontOfSize(14)
        timeLabel.textColor = UIColor.whiteColor()
        menuView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            make.right.equalTo(screenButton.snp_leftMargin).offset(-10)
            make.centerY.equalTo(menuView.height/2.0)
            make.height.equalTo(20)
        }
        
        slider = UISlider()
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.minimumTrackTintColor = UIColor(colorLiteralRed: 69/255.0, green: 60/255.0, blue: 76/255.0, alpha: 1)
        slider.maximumTrackTintColor = UIColor.clearColor()
        slider.setThumbImage(UIImage.init(named: "dot"), forState: .Normal)
        slider.value = 0.0
        slider.addTarget(self, action: #selector(self.sliderDragged), forControlEvents: .ValueChanged)

        menuView.addSubview(slider)
        slider.snp_makeConstraints { (make) in
            make.left.equalTo(playButton.snp_rightMargin).offset(20)
            make.right.equalTo(timeLabel.snp_leftMargin).offset(-15)
            make.centerY.equalTo(menuView.height/2.0)
        }
        
        progressView = UIProgressView.init(progressViewStyle: .Default)
        progressView.progressTintColor = UIColor.clearColor()
        progressView.trackTintColor = UIColor.lightGrayColor()
        menuView.addSubview(progressView)
        menuView.insertSubview(progressView, belowSubview: slider)
        progressView.snp_makeConstraints { (make) in
            make.left.equalTo(slider)
            make.right.equalTo(slider)
            make.center.equalTo(slider)
            make.height.equalTo(1.5)
        }
        menuView.hidden = true
        self.showMenuView = false
    }
    
    func showFailedLabel(title: NSString , textColor: UIColor , fontSize: CGFloat) {
        self.removeFailedLabel()
        self.failLabel = UILabel()
        self.failLabel.text = title as String
        self.failLabel.textColor = textColor
        self.failLabel.font = UIFont.systemFontOfSize(fontSize)
        self.failLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.failLabel)
        self.failLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(14)
        }
    }
    
    func removeFailedLabel() {
        if self.failLabel != nil {
            self.failLabel.removeFromSuperview()
            self.failLabel = nil
        }
    }
    
    func setupVideoURL(url: NSString)  {
        let url = NSURL.init(string: url as String)
        ltPlayerItem = AVPlayerItem.init(URL: url!)
        if ltPlayerItem == nil {
            return;
        }
        if ltPlayer == nil {
            ltPlayer = AVPlayer.init(playerItem: ltPlayerItem)
        }
        
        if ltPlayerLayer == nil {
            ltPlayerLayer = AVPlayerLayer.init(player: ltPlayer)
        }
        ltPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        ltPlayerLayer.contentsScale = UIScreen.mainScreen().scale
        self.layer.insertSublayer(ltPlayerLayer, atIndex: 0)
        
        ltPlayerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.New, context: nil)
        ltPlayerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playbackFinished(_:)), name: AVPlayerItemDidPlayToEndTimeNotification, object: ltPlayerItem)
    }
    
    
    //添加手势
    func addPlayerGesture() {
        //单击
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(LTPlayerView.oneTap))
        oneTap.numberOfTapsRequired = 1
        oneTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(oneTap)
    }
    
    func doubleTap() { //双击事件
        self.playOrPause()
    }
    
    func oneTap() { //单击事件
        if self.showMenuView == true {
            //点击隐藏菜单栏
            self.menuView.hidden = true
            self.showMenuView = false
            return
        }
        //点击关闭
        self.menuView.hidden = false
        self.showMenuView = true
    }
    
    //播放器进度监控
    func addProgressObserver() {
        weak var weakSelf = self
        self.playbackTimeObserver = self.ltPlayer.addPeriodicTimeObserverForInterval(CMTimeMake(1, 10), queue: dispatch_get_main_queue()) { (time : CMTime) in
            let current = CMTimeGetSeconds(time)
            print(current)
            weakSelf?.updateProgress()
        }
    }
    
    //拖动进度条
    func sliderDragged ()  {
        if self.ltPlayer.rate == 0 { //暂停
            ltPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(slider.value) * self.duration, ltPlayerItem.currentTime().timescale))
            ltPlayer.play()
            playButton.selected = true
            return
        }
        playButton.selected = false
        print(Float64(slider.value),ltPlayer.rate)
        ltPlayer.pause()
        ltPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(slider.value) * self.duration, ltPlayerItem.currentTime().timescale))
        ltPlayer.play()
        playButton.selected = true
    }
    
    //全屏/小屏
    func toFullScreen() {
        screenButton.selected = !screenButton.selected
        if screenButton.selected {
            self.navigationController()!.setNavigationBarHidden(true, animated: false)
            self.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth)
            menuView.updateConstraints()
            AppDelegate().getAppdelegate().allowRotation = true
            UIView.animateWithDuration(0.38, animations: {
                UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
                UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
            }) { (finished:Bool) in
                
            }
            isFullScreen = true
            return
        }
        self.navigationController()!.setNavigationBarHidden(false, animated: false)
        self.frame = originRect
        self.updateConstraints()
        AppDelegate().getAppdelegate().allowRotation = false
        UIView.animateWithDuration(0.38, animations: {
            UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey:
                "orientation")
            UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")

        }) { (finished:Bool) in
    
        }
        isFullScreen = false
    }
    
    //播放/暂停
    func playOrPause() -> Void {
        playButton.selected = !playButton.selected
        if playButton.selected {
            ltPlayer.play()
            return
        }
        ltPlayer.pause()
    }

    //更新进度
    func updateProgress() {
        let currentTime = CMTimeGetSeconds(self.ltPlayer.currentTime())
        let totalTime = self.duration

        self.updateTime(CGFloat(currentTime), totalTime: CGFloat(totalTime))
        self.updateSlider(CGFloat(currentTime/totalTime))
    }
    
    //更新滑杆进度
    func updateSlider(currentTime:CGFloat) {
        slider.setValue(Float(currentTime), animated: true)
    }
    
    //时间
    func updateTime(currentTime: CGFloat, totalTime: CGFloat) {
        let videoCurrent = ceil(currentTime)
        let videoTotal = ceil(totalTime)

        var time: String = ""
        if videoCurrent < 3600 {
            time = NSString.init(format: "%02d:%02d/%02d:%02d", Int(videoCurrent/60.0),Int(videoCurrent%60.0),Int(videoTotal/60.0),Int(videoTotal%60.0)) as String
        } else {
            time = NSString.init(format: "%02d:%02d:%02d/%02d:%02d:%02d", Int(videoCurrent/3600.0),Int((videoCurrent%3600.0)/60.0),Int(videoCurrent/60.0),Int(videoTotal/3600.0),Int((videoTotal%3600.0)/60.0),Int(videoTotal/60.0)) as String
        }
        timeLabel.text = time
    }
    
    //获取缓冲总进度
    func getLoadedTime() -> NSTimeInterval {
        let loadedTimeRanges = self.ltPlayer.currentItem!.loadedTimeRanges
        let timeRange = loadedTimeRanges.first?.CMTimeRangeValue
        let startSecs = CMTimeGetSeconds(timeRange!.start)
        let durationSecs = CMTimeGetSeconds(timeRange!.duration)
        let loadedTime = startSecs + durationSecs //缓冲总进度
        return loadedTime
    }
    
    
    // MARK: KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == "loadedTimeRanges" { //缓冲进度
            let totalDuration = CMTimeGetSeconds(playerItem.duration)
            progressView.progressTintColor = UIColor.grayColor()
            progressView.setProgress(Float(self.getLoadedTime()/totalDuration), animated: true)
        } else if keyPath == "status" {
            if playerItem.status == .ReadyToPlay {
                actIndicator.stopAnimating()
                self.removeFailedLabel()
                ltPlayer.play()
                playButton.selected = true
                self.duration = CMTimeGetSeconds(self.ltPlayer.currentItem!.asset.duration)
                self.addProgressObserver()
                //添加双击手势
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(LTPlayerView.doubleTap))
                doubleTap.numberOfTapsRequired = 2
                self.addGestureRecognizer(doubleTap)
            } else if playerItem.status == .Failed {
                print("loadingFailed...")
                actIndicator.stopAnimating()
                self.showFailedLabel("视频加载失败", textColor: UIColor.whiteColor(), fontSize: 13)
                self.removeFailedLabel()
            }  else if playerItem.status == .Unknown {
                print("loadingUnknown...")
                self.showFailedLabel("视频加载失败", textColor: UIColor.whiteColor(), fontSize: 13)
            }
        }
    }
    
    // MARK: play finished
    func playbackFinished(notification: NSNotification) {
        print("play finished")
        playButton.selected = false
        slider.value = 0.0
        let frameRate : Int32 = (ltPlayer?.currentItem?.currentTime().timescale)!
        ltPlayer?.currentItem?.seekToTime(CMTimeMakeWithSeconds(0, frameRate))

    }
    
    // MARK:获取当前导航控制器
    func navigationController() -> UINavigationController? {
        var next = self.nextResponder()
        repeat {
            if next is UINavigationController {
                return next as? UINavigationController
            }
            next = next?.nextResponder()
        } while next != nil
        
        return nil
    }
    
    // MARK: 释放播放器
    func releasePlayer() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        if self.playbackTimeObserver != nil {
            self.ltPlayer.removeTimeObserver(self.playbackTimeObserver!)
            self.playbackTimeObserver = nil
        }

        if self.ltPlayerItem != nil {
            self.ltPlayerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
            self.ltPlayerItem.removeObserver(self, forKeyPath: "status")
            self.ltPlayerItem = nil
        }

        if self.ltPlayer != nil {
            self.ltPlayer.pause()
            self.ltPlayer.currentItem?.asset.cancelLoading()
            self.ltPlayer = nil
        }
        
        /*
        if self.displayLink != nil {
            self.displayLink.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            self.displayLink.invalidate()
            self.displayLink = nil
            
        }*/

    }
    
    // MARK: deinit
    deinit {
        self.releasePlayer()
        print("\(self) deinit")
    }
    
    
    /*
     //定时器
     func setDisplayLink() {
     if displayLink == nil {
     displayLink = CADisplayLink.init(target: self, selector: #selector(self.updateProgress))
     displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
     }
     }
     */
}
