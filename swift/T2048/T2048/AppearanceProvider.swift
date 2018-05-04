//
//  AppearanceProvider.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//
//外观的提供者，按规则显示提供颜色和字体大小

import UIKit

//开发者为什么使用该协议呢？猜想，这样可以将显示属性（颜色、字体）相关的逻辑从TileView逻辑中独立出来，便于统一修改和调试
protocol AppearanceProviderProtocol: class {
  func tileColor(_ value: Int) -> UIColor //根据值，返回棋子的背景颜色
  func numberColor(_ value: Int) -> UIColor //根据值，返回棋子的数字颜色
  func fontForNumbers() -> UIFont  //返回数字使用的字体
}

//上面协议的实现，按典型的switch-case结构。有多少情况，只要预先设定好，即可
class AppearanceProvider: AppearanceProviderProtocol {

  // Provide a tile color for a given value
  func tileColor(_ value: Int) -> UIColor {
    switch value {
    case 2:
      return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    case 4:
      return UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    case 8:
      return UIColor(red: 242.0/255.0, green: 177.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    case 16:
      return UIColor(red: 245.0/255.0, green: 149.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    case 32:
      return UIColor(red: 246.0/255.0, green: 124.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    case 64:
      return UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0)
    case 128, 256, 512, 1024, 2048:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    default:
      return UIColor.white
    }
  }

  // Provide a numeral color for a given value
  func numberColor(_ value: Int) -> UIColor {
    switch value {
    case 2, 4:
      return UIColor(red: 119.0/255.0, green: 110.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    default:
      return UIColor.white
    }
  }

  // Provide the font to be used on the number tiles
  func fontForNumbers() -> UIFont {
    if let font = UIFont(name: "HelveticaNeue-Bold", size: 20) {
      return font
    }
    return UIFont.systemFont(ofSize: 20)
  }
}
