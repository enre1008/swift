//
//  ViewController.swift
//  CustomFont
//
//  Created by Sunny－Joy on 2017/12/26.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "I am the king of the world"    //设置创建的label的文字内容
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in        //SnapKit是约束管理，对创建的label进行位置的约束
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        label.font = UIFont.systemFont(ofSize: 30)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("Change Font Family", for: UIControlState.normal)
        changeBtn.addTarget(self, action: #selector(changeFontFamily), for:
             UIControlEvents.touchUpInside)       //设置对button的触碰所带来的结果，是调用方法changeFontFamily
        changeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        self.view.addSubview(changeBtn)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.cornerRadius = 5
        changeBtn.snp.makeConstraints { (make) in   //SnapKit，对创建的button进行位置、边框颜色、粗细进行约束
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }
        printAllSupportedFontNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeFontFamily(){        //点击button之后，执行该方法，该方法功能是更改label中的字体
        label.font = UIFont(name: "Savoye LET", size: 30)
    }
    
    func printAllSupportedFontNames() {             //在终端，打印出所有字体
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("++++++ \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("   ------ \(fontName)")
            }
        }
    }
}

