//
//  ViewController.swift
//  WatchDemo
//
//  Created by Sunny－Joy on 2017/12/28.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var result: UILabel!
    var timer:Timer!
    var labelNumber:Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let startView = UIView()
        
        result = UILabel()            //点击start之后的result用label来显示，没有单独创建view
        self.view.addSubview(result)
        result.textColor = UIColor.black
        result.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(25)
            make.top.equalTo(100)
        }
        result.font = UIFont.systemFont(ofSize: 30)  //设置result显示的字体、大小
        result.text = "0"        //设置初值为0
        
        startView.backgroundColor = UIColor.init(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1) //start区域为view，并设置其背景颜色
        self.view.addSubview(startView)                //添加到主view
        startView.snp.makeConstraints { (make) in      //设置startView的位置
            make.top.equalTo(self.view).offset(300)
            make.left.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.width.equalTo(self.view.frame.width / 2)
        }
        
        let startButton: UIButton = UIButton()       //创建start button
        startButton.setTitle("Start", for: UIControlState.normal)   //设置button的内容为Start，并设为平常状态下这样显示
        startView.addSubview(startButton)            //将button添加到startView中
        startButton.snp.makeConstraints { (make) in  //设置button的位置
            make.center.equalTo(startView)
            make.width.height.equalTo(50)
        }
        startButton.addTarget(self, action: #selector(startHandler), for: UIControlEvents.touchUpInside)
                                    //点击button，即有touchUpInside操作之后，将调用startHandler方法
        
        let endView = UIView()      //创建endView
        endView.backgroundColor = UIColor.init(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)  //设置其背景颜色
        self.view.addSubview(endView)   //将endView添加到主view
        endView.snp.makeConstraints { (make) in     //设置endView位置
            make.top.equalTo(self.view).offset(300)
            make.right.equalTo(self.view).offset(0)
            make.width.equalTo(self.view.frame.width / 2)
            make.bottom.equalTo(self.view).offset(0)
        }
        
        let endButton: UIButton = UIButton()    //创建end button
        endButton.setTitle("End", for: UIControlState.normal)
        endView.addSubview(endButton)
        endButton.snp.makeConstraints { (make) in
            make.center.equalTo(endView).offset(0)
            make.width.height.equalTo(50)
        }
        endButton.addTarget(self, action: #selector(stopHandler), for: UIControlEvents.touchUpInside)
        
        let resetButton = UIButton()      //创建reset button
        self.view.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        resetButton.setTitle("Reset", for: UIControlState.normal)
        resetButton.setTitleColor(UIColor.blue, for: UIControlState.normal)  //设置在normal时button内容的字体颜色
        resetButton.addTarget(self, action: #selector(resetHandler), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func startHandler() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (Timer) in    //间隔时间设为0.1秒
            self.labelNumber = self.labelNumber + 0.1      //以0.1秒递增
            self.result.text = String(format: "%.1f", self.labelNumber)  //改为字符串形式再赋值给result的text属性
        }
        self.timer.fire()  //启动timer，用fire方法时要求repeats为true
    }
    
    @objc func stopHandler() {
        guard let timerForDistory = self.timer
            else {return}
        timerForDistory.invalidate()  //结束timer
    }
    
    @objc func resetHandler() {
        self.labelNumber = 0    //startHandler中计算时用到的值，故reset时必须重新设为0
        self.result.text = "0"  //在result区域显示的值，重新设为0
    }
}

