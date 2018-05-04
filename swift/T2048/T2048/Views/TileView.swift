//
//  TileView.swift
//  T2048
//
//  Created by Sunny－Joy on 2017/9/5.
//  Copyright © 2017年 Sunny. All rights reserved.
//
//棋子view

import UIKit

/// A view representing a single T2048 tile.
class TileView: UIView {
    var value: Int = 0 {
        didSet {
            backgroundColor = delegate.tileColor(value) //棋子的背景
            numberLabel.textColor = delegate.numberColor(value) //数字的颜色
            numberLabel.text = "\(value)" //值
        }
    }
    
    unowned let delegate: AppearanceProviderProtocol //显示信息委托
    let numberLabel: UILabel //显示数字的label
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(position: CGPoint, width: CGFloat, value: Int, radius: CGFloat, delegate d: AppearanceProviderProtocol){
        delegate = d
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = delegate.fontForNumbers()
        
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        addSubview(numberLabel)
        layer.cornerRadius = radius
        
        self.value = value
        backgroundColor = delegate.tileColor(value)
        numberLabel.textColor = delegate.numberColor(value)
        numberLabel.text = "\(value)"
    }
}
