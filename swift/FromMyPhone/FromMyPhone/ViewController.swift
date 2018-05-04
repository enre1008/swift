//
//  ViewController.swift
//  FromMyPhone
//
//  Created by Sunny－Joy on 2018/4/25.
//  Copyright © 2018年 Sunny. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 1/255.0, green: 1/255.0, blue: 0/255.0, alpha: 1)
        //self.view.backgroundColor = UIColor.gray
        
        let documentsPath = NSHomeDirectory() + "/Documents"
        //let documentsPath = NSHomeDirectory()
        let webUploader = GCDWebUploader(uploadDirectory: documentsPath)
        webUploader.start(withPort: 8080, bonjourName: "Web Based Uploads")
        let showServerIP = UITextView()
        showServerIP.frame.size = CGSize(width: 320, height: 120)
        showServerIP.backgroundColor = UIColor(displayP3Red: 22/255.0, green: 139/255.0, blue: 3/255.0, alpha: 0)
        showServerIP.center.x = self.view.center.x
        showServerIP.center.y = self.view.center.y - 50
        showServerIP.isEditable = false
        showServerIP.textColor = UIColor.white
        showServerIP.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(showServerIP)
        
        //设置showServerIP的文字内容部分
        if let serverURL = webUploader.serverURL {
            showServerIP.text = "服务启动成功，请使用浏览器访问:\n\n\(serverURL)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

