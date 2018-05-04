//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Sunny－Joy on 2018/3/5.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellHeight: CGFloat = 66
    let dataSource = ["Position", "Opacity", "Sacle", "Color", "Rotation"]
    var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        table = UITableView(frame: self.view.frame)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Must have it
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // Must have it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BasicAnimationReusableTableCellView")
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(PositionAnimationViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(OpacityAnimationViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(ScaleAnimationViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(ColorAnimationViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(RotationAnimationViewController(), animated: true)
        default:
            return
        }
    }
    
    
    
    
}

