//
//  ViewController.swift
//  LoginAnimation
//
//  Created by Sunny－Joy on 2018/3/1.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let buttonHeight: CGFloat = 56
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 25/255.0, green: 153/255.0, blue: 3/255.0, alpha: 1)
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 334, height: 101))
        logoImageView.image = #imageLiteral(resourceName: "logo.png")
        logoImageView.center.x = self.view.center.x
        self.view.addSubview(logoImageView)
        
        let loginBtn = UIButton(frame: CGRect(x: 0, y: (self.view.frame.size.height - buttonHeight), width: self.view.frame.width / 2.0, height: buttonHeight))
        loginBtn.setTitle("LOG IN", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.backgroundColor = UIColor.black
        self.view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(tapAction), for: UIControlEvents.touchUpInside)
        
        let signupBtn = UIButton(frame: CGRect(x: self.view.frame.width / 2.0, y: (self.view.frame.size.height - buttonHeight), width: self.view.frame.width / 2.0, height: buttonHeight))
        signupBtn.setTitle("SIGN UP", for: UIControlState.normal)
        signupBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        signupBtn.backgroundColor = UIColor.green
        self.view.addSubview(signupBtn)
    }
    
    @objc func tapAction() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
}

