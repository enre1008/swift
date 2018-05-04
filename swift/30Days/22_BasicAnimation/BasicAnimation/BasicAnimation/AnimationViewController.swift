//
//  AnimationViewController.swift
//  BasicAnimation
//
//  Created by Sunny－Joy on 2018/3/5.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class PositionAnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        let rockmanView = UIImageView(image: #imageLiteral(resourceName: "rockman"))
        rockmanView.frame.size = CGSize(width: 200, height: 200)
        rockmanView.center.y = self.view.center.y
        rockmanView.frame.origin.x = 10
        self.view.addSubview(rockmanView)
        
        let triggerButton = UIButton(type: .roundedRect)
        triggerButton.frame.size = CGSize(width: 100, height: 50)
        triggerButton.layer.borderWidth = 1
        triggerButton.layer.borderColor = UIColor.black.cgColor
        triggerButton.setTitle("Fire", for: UIControlState.normal)
        triggerButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        triggerButton.center.x = self.view.center.x
        triggerButton.frame.origin.y = self.view.frame.height - 150
        self.view.addSubview(triggerButton)
        triggerButton.addTarget(self, action: #selector(fire), for: UIControlEvents.touchUpInside)
    }
    
    @objc func fire() {
        let bulletView = UIView()
        bulletView.frame.size = CGSize(width: 10, height: 10)
        bulletView.layer.cornerRadius = 5
        bulletView.layer.masksToBounds = true
        bulletView.backgroundColor = UIColor.green
        bulletView.frame.origin.x = 180
        bulletView.frame.origin.y = self.view.center.y - 10
        self.view.addSubview(bulletView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            bulletView.frame.origin.x = self.view.frame.width + 10
        }, completion: { (_) in
            bulletView.removeFromSuperview()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class OpacityAnimationViewController: UIViewController {
    var steveView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.green
        steveView = UIImageView(image: #imageLiteral(resourceName: "steveJobs"))
        steveView.frame = self.view.frame
        steveView.alpha = 0
        self.view.addSubview(steveView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.3, options: .allowAnimatedContent, animations: {
            self.steveView.alpha = 1
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class ScaleAnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        let heartView = UIImageView(image: #imageLiteral(resourceName: "heart"))
        heartView.frame.size = CGSize(width: 224, height: 240)
        heartView.center = self.view.center
        self.view.addSubview(heartView)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent, animations: {
                heartView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, animations: {
                    heartView.transform = CGAffineTransform.identity
                })
            })
        }
        timer.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}

class ColorAnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        let nameLabel = UILabel()
        nameLabel.text = "Sunny"
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 40)
        nameLabel.sizeToFit()
        self.view.addSubview(nameLabel)
        nameLabel.center = self.view.center
        
        UIView.animate(withDuration: 1, animations: {
            self.view.backgroundColor = UIColor.green
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class RotationAnimationViewController: UIViewController {
    var rollingBallView: UIImageView!
    var angle: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        rollingBallView = UIImageView(image: #imageLiteral(resourceName: "rollingBall"))
        rollingBallView.frame.size = CGSize(width: 110, height: 110)
        rollingBallView.center = self.view.center
        self.view.addSubview(rollingBallView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (_) in
            self.angle = self.angle + 0.04
            if self.angle > 6.28 {
                self.angle = 0
            }
            UIView.animate(withDuration: 0.02, animations: {
                self.rollingBallView.transform = CGAffineTransform(rotationAngle: self.angle)
            })
        })
        timer.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
