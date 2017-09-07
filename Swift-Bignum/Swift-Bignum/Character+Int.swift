//
//  Character+Int.swift
//  Swift-Bignum
//
//  Created by afer on 2017/9/6.
//  Copyright © 2017年 afer. All rights reserved.
//

import Cocoa

extension Character {
    func toInt() -> Int {
        return Int("\(self)")!
    }
}
