//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Sunny－Joy on 2018/1/6.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let videoButton = UIButton()
        videoButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        videoButton.setTitle("Play Video", for: UIControlState.normal)
        videoButton.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        self.view.addSubview(videoButton)
        videoButton.addTarget(self, action: #selector(playVideo), for: UIControlEvents.touchUpInside)
        
        let audioPlayButton = UIButton()
        audioPlayButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPlayButton.setTitle("Play Audio", for: UIControlState.normal)
        audioPlayButton.frame = CGRect(x: 50, y: 150, width: 100, height: 50)
        self.view.addSubview(audioPlayButton)
        audioPlayButton.addTarget(self, action: #selector(playAudio), for: UIControlEvents.touchUpInside)
        
        let audioPauseButton = UIButton()
        audioPauseButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        audioPauseButton.setTitle("Pause Audio", for: UIControlState.normal)
        audioPauseButton.frame = CGRect(x: 50, y: 250, width: 100, height: 50)
        self.view.addSubview(audioPauseButton)
        audioPauseButton.addTarget(self, action: #selector(pauseAudio), for: UIControlEvents.touchUpInside)
        
        initAudio()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        initForLockScreen()
    }
    
   /* override func viewDidAppear(_ animated: Bool) {
        
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func playVideo() {
        // let videoUrl = URL(string: "http://down.trney.com/mov/test.mp4")  //指定网上的视频路径
        let path = Bundle.main.path(forResource: "emojiZone", ofType: "mp4") //定义本地的视频文件路径
        let videoUrl = URL(fileURLWithPath: path!)
        let player = AVPlayer(url: videoUrl)      //定义一个视频播放器，通过本地文件路径初始化
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true){}
        //下一段代码也可以播放视频，只是没有在全屏状态下播放视频，故能看到前一页的操作按钮
           // let path = Bundle.main.path(forResource: "emojiZone", ofType: "mp4") //定义本地的视频文件路径
           // let videoUrl = URL(fileURLWithPath: path!)
           // let player = AVPlayer(url: videoUrl)
           // let playerLayer =  AVPlayerLayer(player: player)  //设置大小和位置（全屏）
           // playerLayer.frame = self.view.bounds
           // self.view.layer.addSublayer(playerLayer)  //添加到界面上
           // player.play()   //开始播放
    }
    
    func initAudio() {
        let audioPath = Bundle.main.path(forResource: "live", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        }
        catch {
            audioPlayer = nil
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord) //设置后台播放
            try AVAudioSession.sharedInstance().setActive(true) //设置后台播放
        }catch {
            print("error")
        }
    }
    
    func initForLockScreen() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle:"皇后大道东",
            MPMediaItemPropertyArtist:"罗大佑",
           //MPMediaItemPropertyArtwork:MPMediaItemArtwork (image: UIImage(named: "thumb.jpb")!),
            MPNowPlayingInfoPropertyPlaybackRate:1.0,
            MPMediaItemPropertyPlaybackDuration:audioPlayer?.duration as Any,
            MPNowPlayingInfoPropertyElapsedPlaybackTime:audioPlayer?.currentTime as Any
        ]
    }

    @objc func playAudio() {
        audioPlayer?.play()
    }
    
    @objc func pauseAudio() {
        audioPlayer?.pause()
    }
    
    //锁屏时对歌曲，进行播放、暂停、停止操作
    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:
            audioPlayer?.play()
        case .remoteControlPause:
            audioPlayer?.pause()
        case .remoteControlStop:
            audioPlayer?.stop()
        default:
            break
        }
    }
}

