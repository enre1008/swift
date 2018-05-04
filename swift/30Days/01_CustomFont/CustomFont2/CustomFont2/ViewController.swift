//
//  ViewController.swift
//  CustomFont2
//
//  Created by Sunny－Joy on 2017/12/28.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!  //从storyboard中接收变量label，因为创建链接时在弹出的窗口中connecion选择了outlet

    @IBAction func ChangeBtn(_ sender: UIButton) {  //在创建链接时在弹出的窗口中connecion选择了Action，故在这里是相应的方法
        //sender.setTitle(UIColor.blue, for: UIControlState.normal)
        sender.addTarget(self, action: #selector(changeFontFamily), for: UIControlEvents.touchUpInside)
        sender.layer.borderColor = UIColor.blue.cgColor
        sender.layer.borderWidth = 1
        sender.layer.cornerRadius = 5
        sender.snp.makeConstraints { (make) in
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }
    }
    
    @objc func changeFontFamily() {
        label.font = UIFont(name: "Savoye LET", size: 30)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

