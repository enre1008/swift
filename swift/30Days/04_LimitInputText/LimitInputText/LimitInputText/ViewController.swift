//  ViewController.swift
//  LimitInputText
//
//  Created by Sunny－Joy on 2018/1/1.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    var limitedTextView: UITextView!
    var allowInputNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initNavigationBar()
        self.initInputField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initInputField() {
        let naviFrame = self.navigationController?.navigationBar.frame
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (naviFrame?.height)! + statusBarFrame.height + 10, width: 70, height: 70))
            // 位于屏幕上面的图片的y坐标 = 导航栏+状态栏的高度+10，由此确定了frame的左上角点的坐标信息
        avatarImgView.image = #imageLiteral(resourceName: "avatar.jpg")
        self.view.addSubview(avatarImgView)
        
        limitedTextView = UITextView(frame: CGRect(x: 80, y: avatarImgView.frame.height, width: self.view.frame.width - 70 - 20, height: 300))
        self.view.addSubview(limitedTextView)
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        
        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width - 50, y: self.view.frame.height - 40, width: 50, height: 40))
          // 该label在屏幕右下角，在右侧时，x = self.view.fram.width - 50，若想位于屏幕左下角需 x=0
          // 在屏幕下面时，y坐标取值为self.view.frame.height - 40, 若想在上面需像30行代码，需要累加导航栏等的高度
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.text = "140"
        allowInputNumberLabel.textAlignment = .right
    }
    
    func initNavigationBar() {
        let leftItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: nil) //创建navigationBarItem的左item
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: nil) //创建navigationBarItem的右item
        rightItem.tintColor = UIColor.green  //指定button内容的字体颜色为绿色
        navigationItem.rightBarButtonItem = rightItem
    }
    
    //    todo need to limit the paste action so that the length might be exceed!
    func textViewDidChange(_ textView: UITextView) {
        let currentCharactorCount = (textView.text?.count)!
        if  currentCharactorCount >= 140 {
            limitedTextView.resignFirstResponder() //强制limitedTextView放弃第一响应者身份，即此时不能再输入字符
        }
        allowInputNumberLabel.text = "\(140 - currentCharactorCount)"
    }
    
    @objc func keyboardWillChangeFrame(note: Notification) {
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval //拿到键盘弹出时间
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //拿到键盘frame
        let y = endFrame.origin.y   //拿到键盘的高度
        
        
        let margin = UIScreen.main.bounds.height - y  //计算工具栏距离底部的间距
        UIView.animate(withDuration: duration) {
            if margin > 0 {   //键盘弹出
                self.allowInputNumberLabel.frame.origin.y = self.allowInputNumberLabel.frame.origin.y - margin
            }
            else {   //键盘收起
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40
            }
        }
    }
}


