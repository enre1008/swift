//
//  fetchSubString.swift
//  ColorGradient
//
//  Created by Sunny－Joy on 2018/1/11.
//  Copyright © 2018年 Sunny. All rights reserved.
//

import Foundation

extension String {
    subscript (r:Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}
