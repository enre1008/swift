//
//  ViewController.swift
//  StretchyHeader
//
//  Created by Sunny－Joy on 2018/1/14.
//  Copyright © 2018年 Sunny. All rights reserved.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private let cellHeight:CGFloat = 66
    private let colorRatio:CGFloat = 10
    var bannerImgView: UIImageView!
    var table: UITableView!
    private let lyric = "when i was young i'd listen to the radio,waiting for my favorite songs,when they played i'd sing along,it make me smile"
    private var dataSource: Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView()
        table.frame = CGRect(x: 0, y: self.view.frame.width + 10, width: self.view.frame.width, height: self.view.frame.height - 10 - self.view.frame.width)
            //1.定义了一个四方形的左上角点、宽度、高度
            //2.如果某两个view的x，y坐标值一样且都执行了self.view.addSubview()，则最后一次执行的将覆盖之前的
            //3.table的y是在bannerImgView的y坐标基础上再加了10，意欲要错开两个view，防止后面的覆盖之前的
            //4.table的y，self.view.frame.width + 10意味着从屏幕上面开始往下，frame的width+10的高度开始记为y值
            //5.若y: self.view.frame.height - 30，即由frame的本身高度减的话，意味着y值是从屏幕下面开始往上30开始记
            //6.若y: self.view.frame.height - self.view.frame.width + 50，先从屏幕下面往上记frame的width，然后从那个位置开始再往下记50的位置为y取值点
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        
        bannerImgView = UIImageView(image: #imageLiteral(resourceName: "banner.jpg"))
        bannerImgView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        self.view.addSubview(bannerImgView)
            //bannerImgView是后加到view的,所以如果此frame的x和y坐标与table一致，则可以覆盖table，即lyric不能显示出来
        
        self.dataSource = lyric.split(separator: ",").map(String.init)
    }
    
    //这里的cell是定义，怎样实现弹簧动画的呈现
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()  //重新加载数据
        let cells = table.visibleCells //在viewWillAppear中执行动画，而不是在delegate “willDisplay”中，否则将会导致重用单元问题!
        let tableHeight: CGFloat = table.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.frame.origin.y = tableHeight
            UIView.animate(withDuration: 1.0, delay: 0.04 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.frame.origin.y = 0
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //继承UITableViewDataSource协议时，两个必须实现的协议方法之一，设定行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    //UITableViewDataSource协议时，两个必须实现的协议方法之一，设定cell中内容
    //这里的cell是定义，内容、字体颜色
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "animationInTableViewCell")
        cell.textLabel?.text = self.dataSource[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.frame.origin.y = self.cellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y  //取scrollView被拉动的位移
        let maxOffsetY = table.frame.height       //设scrollView可被拉动的最大位移
        let validateOffsetY = -offsetY / maxOffsetY
        let scaleFactor = 1 + validateOffsetY
        bannerImgView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
               //注：若将scaleX设为0，开始静止时图片在上方，经向上或向下拖拽之后图片消失了
    }
}

