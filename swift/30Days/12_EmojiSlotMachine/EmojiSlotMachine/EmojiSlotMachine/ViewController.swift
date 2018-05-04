//
//  ViewController.swift
//  EmojiSlotMachine
//
//  Created by Sunny－Joy on 2018/1/18.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    var slotMachine: UIPickerView!
    var emojiArray = ["😀","😎","😈","👻","🙈","🐶","🍒","🍎","💔","🦄","🏀"]
    var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSlotMachine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createSlotMachine() {
        slotMachine = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220))
        self.view.addSubview(slotMachine)
        slotMachine.dataSource = self
        slotMachine.delegate = self
        slotMachine.center.x = self.view.center.x
        slotMachine.center.y = self.view.center.y - 50
        
        let goButton = UIButton(type: .roundedRect)
        goButton.frame = CGRect(x: 0, y: 0, width: 275, height: 40)
        self.view.addSubview(goButton)
        goButton.setTitle("Go", for: UIControlState.normal)
        goButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        goButton.backgroundColor = UIColor.yellow
        goButton.center.x = self.view.center.x
        goButton.center.y = slotMachine.center.y + 180
        goButton.addTarget(self, action: #selector(goAction), for: UIControlEvents.touchUpInside)
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.view.addSubview(resultLabel)
        resultLabel.text = ""
        resultLabel.textAlignment = .center
        resultLabel.textColor = UIColor.black
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.center.x = self.view.center.x
        resultLabel.center.y = goButton.center.y + 80
        
        let longTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        longTapGesture.numberOfTapsRequired = 2
        goButton.addGestureRecognizer(longTapGesture)
        
    }
    
    @objc func goAction() {
        slotMachine.selectRow(Int(arc4random())%emojiArray.count, inComponent: 0, animated: true)
        slotMachine.selectRow(Int(arc4random())%emojiArray.count, inComponent: 1, animated: true)
        slotMachine.selectRow(Int(arc4random())%emojiArray.count, inComponent: 2, animated: true)
        
        self.judge()
    }
    
    @objc func doubleTapGesture() {
        let result = Int(arc4random())%emojiArray.count
        slotMachine.selectRow(result, inComponent: 0, animated: true)
        slotMachine.selectRow(result, inComponent: 1, animated: true)
        slotMachine.selectRow(result, inComponent: 2, animated: true)
        
        self.judge()
    }
    
    func judge() {
        if slotMachine.selectedRow(inComponent: 0) == slotMachine.selectedRow(inComponent: 1) &&
            slotMachine.selectedRow(inComponent: 1) == slotMachine.selectedRow(inComponent: 2) {
            resultLabel.text = "👏👏👏"
        }else {
            resultLabel.text = "💔💔💔"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = emojiArray[row]
        pickerLabel.textAlignment = .center
        pickerLabel.font = UIFont.systemFont(ofSize: 60)
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }
}
