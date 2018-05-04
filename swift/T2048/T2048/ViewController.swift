//
//  ViewController.swift
//  T2048
//
//  Created by Sunny－Joy on 2017/9/2.
//  Copyright © 2017年 Sunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        let game = NumberTileGameViewController(dimension: 4, threshold: 2048)
        self.present(game, animated: true,completion: nil)
    }
}

