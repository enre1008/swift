//
//  ViewController.swift
//  TumblrMenu
//
//  Created by Sunny－Joy on 2018/2/8.
//  Copyright © 2018年 Sunny. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    var blurView: UIVisualEffectView!
    var alphaBtn: UIButton!
    let dampingRate: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImg = UIImageView(frame: self.view.frame)
        bgImg.image = #imageLiteral(resourceName: "LaunchImage-800-667h@2x.png")
        self.view.addSubview(bgImg)
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tapGest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tapAction() {
        self.setupFunctions()
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(removeBlur))
        blurView.addGestureRecognizer(tapGest)
        
        UIView.animate(withDuration: 0.5) {
            self.blurView.alpha = 1
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: dampingRate, initialSpringVelocity: 10, options: .allowAnimatedContent, animations: {
            self.alphaBtn.frame.origin.x = 80
        }, completion: nil)
    }
    
    func setupFunctions() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        
        self.alphaBtn = UIButton(frame: CGRect(x: -88, y: 80, width: 88, height: 88))
        alphaBtn.setImageAndTitle(imageName: "alpha", title: "Message", type: .PositionTop, Space: 10)
        blurView.contentView.addSubview(alphaBtn)
    }
    
    @objc func removeBlur() {
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: .allowAnimatedContent, animations: {
            self.alphaBtn.frame.origin.x = -88
        }) { (isFinished) in
            self.alphaBtn.removeFromSuperview()
            self.blurView.removeFromSuperview()
        }
    }
}
