//
//  ViewController.swift
//  SimplePhotoBrowser
//
//  Created by Sunny－Joy on 2018/1/9.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "samplePhoto.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

