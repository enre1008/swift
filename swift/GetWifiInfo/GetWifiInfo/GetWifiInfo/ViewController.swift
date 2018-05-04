//
//  ViewController.swift
//  GetWifiInfo
//
//  Created by Sunny－Joy on 2018/3/28.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class ViewController: UIViewController{

    var textView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let btn = UIButton(type: .roundedRect)
        btn.frame.size = CGSize(width: 100, height: 50)
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.center.x = self.view.center.x
        btn.center.y = self.view.frame.height - 150
        btn.setTitle("Get Wifi Info", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(wifiInfo), for: UIControlEvents.touchUpInside)
        
        textView = UITextView()
        textView.frame.size = CGSize(width: 400, height: 300)
        textView.center = self.view.center
        self.view.addSubview(textView)
        textView.textColor = UIColor.black
        textView.text = "Hello!!"
        textView.textAlignment = NSTextAlignment.center
        textView.font = UIFont.systemFont(ofSize: 30)
    }
    
    @objc func wifiInfo() {
        let wifiInfos = getWifiInfo()
        let  ssid = wifiInfos.ssid
        let  bssid = wifiInfos.bssid
        textView.text = ("Wifi: " + ssid + "\n" + "MAC: " + bssid)
    }
    
    func getWifiInfo() -> (ssid: String, bssid: String){
        var ssid = ""
        var bssid = ""
        if let interfaces: NSArray = CNCopySupportedInterfaces() {
            for sub in interfaces {
                if let dict = CFBridgingRetain(CNCopyCurrentNetworkInfo(sub as! CFString)) {
                    //上述代码需要在真机下运行，模拟器下 CNCopySupportedInterfaces 返回为空
                      ssid = dict["SSID"] as! String
                      bssid = dict["BSSID"] as! String
                }
            }
        }
        print ("Hi~~~")
        print ("111...\(ssid)")
        return (ssid, bssid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

