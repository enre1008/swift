//
//  AccessoryViews2.swift
//  T2048
//
//  Created by Sunny－Joy on 2017/9/5.
//  Copyright © 2017年 Sunny. All rights reserved.
//
//辅助的views，里面含显示得分ScoreView和用来控制作用的ControlView（未实现也未使用）

import UIKit

protocol ScoreViewProtocol {
    func scoreChanged(to s: Int)
}

/// A simple view that displays the player's score.
class ScoreView : UIView, ScoreViewProtocol {
    var score: Int = 0 {
        didSet {
            label.text = "SCORE: \(score)"
        }
    }
    
    let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
    var label: UILabel
    
    init(backgroundColor bgcolor: UIColor, textColor tcolor: UIColor, font: UIFont, radius r: CGFloat) {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.center
        super.init(frame: defaultFrame)
        backgroundColor = tcolor
        label.font = font
        layer.cornerRadius = r
        self.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func scoreChanged(to s: Int) {
        score = s
    }
}

// A simple view that displays several buttons for controlling the app
class ControlView {
    let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
    // TODO: Implement me
}

