//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Sunny－Joy on 2018/1/4.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource = Array<Date>()
    let refresh = UIRefreshControl()
    var table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: self.view.bounds)
        table.frame.origin.y = 44
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        addNewElementToArray()
        refresh.attributedTitle = NSAttributedString(string: "拉什么拉！？ 再拉朕就要碎了")
        refresh.addTarget(self, action: #selector(pullTheRefresh), for: UIControlEvents.valueChanged)
        table.addSubview(refresh)
        table.reloadData()
    }
    
    @objc func pullTheRefresh() {
        addNewElementToArray()
        refresh.endRefreshing()
        table.reloadData()
    }
    
    func addNewElementToArray() {
        dataSource.insert(NSDate() as Date, at: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //继承UITableViewDataSource必须实现的两个方法之一
    //设定行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    //继承UITableViewDataSource必须实现的两个方法之一
    //设定cell中内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseCellForPullToRefresh")
        
        let dateFormatter = DateFormatter() //初始化DateFormatter类
        dateFormatter.dateFormat = "yyyy年MM月dd日/HH时mm分ss秒"  //设置输出格式
        let dateStr = dateFormatter.string(from: dataSource[indexPath.row]) //date转为String
        cell.textLabel?.text = dateStr
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

