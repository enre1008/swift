//
//  LoginViewController.swift
//  LoginAnimation
//
//  Created by Sunny－Joy on 2018/3/2.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 25/255.0, green: 153/255.0, blue: 3/255.0, alpha: 1)
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let usrInputField = UITextField(frame: CGRect(x: -270, y: 50, width: 270, height: 40))
        usrInputField.borderStyle = .roundedRect
        usrInputField.placeholder = "UserName"
        self.view.addSubview(usrInputField)
        
        let pswInputField = UITextField(frame: CGRect(x: -270, y: 100, width: 270, height: 40))
        pswInputField.borderStyle = .roundedRect
        pswInputField.placeholder = "Password"
        self.view.addSubview(pswInputField)
        
        let loginButton = UIButton(frame: CGRect(x: -270, y: 160, width: 125, height: 40))
        loginButton.setTitle("Login", for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginButton.backgroundColor = UIColor(red: 22/255.0, green: 139/255.0, blue: 3/255.0, alpha: 1)
        self.view.addSubview(loginButton)
        
        let cancelButton = UIButton(frame: CGRect(x: -270, y: 220, width: 125, height: 40))
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelButton.backgroundColor = UIColor(red: 22/255.0, green: 139/255.0, blue: 3/255.0, alpha: 1)
        self.view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(retrunMainPg), for: UIControlEvents.touchUpInside)
        
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            usrInputField.center.x = self.view.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            pswInputField.center.x = self.view.center.x
         }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            loginButton.center.x = self.view.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .allowAnimatedContent, animations: {
            cancelButton.center.x = self.view.center.x
        }, completion: nil)
    }
    
    @objc func retrunMainPg() {
        let mainPg = ViewController()
        self.navigationController?.pushViewController(mainPg, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
