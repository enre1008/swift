//
//  ViewController.swift
//  GetMyPhoneFiles
//
//  Created by Sunny－Joy on 2018/4/12.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let cellHeight: CGFloat = 66
    var table: UITableView!
    private let dataSource = ["Start HTTP Server", "Manage Files"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: self.view.frame)
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .singleLine
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    //必须有
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    //必须有
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BasicAnimationReusableTableViewCell")
        cell.textLabel?.text = self.dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.frame.origin.y = self.cellHeight
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(StartHTTPServerAnimationViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(ManageFilesAnimationViewController(), animated: true)
        default:
            return
        }
    }
        
}

class StartHTTPServerAnimationViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = false
            self.view.backgroundColor = UIColor(displayP3Red: 25/255.0, green: 153/255.0, blue: 3/255.0, alpha: 1)
            
            let documentsPath = NSHomeDirectory() + "/Documents"
            let webUploader = GCDWebUploader(uploadDirectory: documentsPath)
            webUploader.start(withPort: 8080, bonjourName: "Web Based Uploads")
            let showServerIP = UITextView()
            showServerIP.frame.size = CGSize(width: 320, height: 80)
            showServerIP.backgroundColor = UIColor(displayP3Red: 22/255.0, green: 139/255.0, blue: 3/255.0, alpha: 0)
            showServerIP.center.x = self.view.center.x
            showServerIP.center.y = self.view.center.y
            showServerIP.textColor = UIColor.white
            showServerIP.font = UIFont.systemFont(ofSize: 17)
            self.view.addSubview(showServerIP)
            
            //设置showServerIP的文字内容部分
            if let serverURL = webUploader.serverURL {
                showServerIP.text = "服务启动成功，请用您的浏览器访问：\n\(serverURL)" //注：.serverURL属性仅在服务器运行时有效
            }
        }
    }
    
class ManageFilesAnimationViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = false
            
        }
}
    
    


