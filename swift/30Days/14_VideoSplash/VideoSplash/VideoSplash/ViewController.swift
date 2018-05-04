//
//  ViewController.swift
//  VideoSplash
//
//  Created by Sunny－Joy on 2018/1/23.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {
    let buttonHeight:CGFloat = 56
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 34, width: 334, height: 101))
        logoImageView.image = #imageLiteral(resourceName: "logo.png")
        logoImageView.center.x = self.view.center.x
        self.view.addSubview(logoImageView)
        
        let loginButton = UIButton(frame: CGRect(x: 0, y: (self.view.frame.height - buttonHeight), width: self.view.frame.size.width / 2.0, height: buttonHeight))
        loginButton.setTitle("LOG IN", for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor(red: 34 / 255.0, green: 36 / 255.0, blue: 38 / 255.0, alpha: 1)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(loginButton)
        
        let signupButton = UIButton(frame: CGRect(x: self.view.frame.size.width / 2.0, y: (self.view.frame.height - buttonHeight), width: self.view.frame.size.width / 2.0, height: buttonHeight))
        signupButton.setTitle("SIGN UP", for: UIControlState.normal)
        signupButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signupButton.backgroundColor = UIColor(red: 42 / 255.0, green: 183 / 255.0, blue: 90 / 255.0, alpha: 1)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(signupButton)
        
    }
   
    public func setupVideoBackground() {
        let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 4.0
        alpha = 0.8
        contentURL = url as NSURL
        
    }
}


