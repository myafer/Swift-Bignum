//
//  main.swift
//  Swift-Bignum
//
//  Created by afer on 2017/9/6.
//  Copyright © 2017年 afer. All rights reserved.
//

import Foundation

for _ in 0...1000000 {
    let r1 = (Int(arc4random()%999999) + 1)
    let temp1 = r1 * (r1 % 2 == 0 ? -1 : 1)
    let r2 = (Int(arc4random()%999999) + 1)
    let temp2 = r2 * (r2 % 2 == 0 ? -1 : 1)
    
    let nadd = "\(temp1 + temp2)"
    let nminus = "\(temp1 - temp2)"
    
    let a = BignumBase(temp1)
    let b = BignumBase(temp2)
    let badd = "\(temp1 + temp2)"
    let bminus = "\(temp1 - temp2)"
    
    if nadd != badd {
        fatalError("add error!")
    }
    
    if nminus != bminus {
        fatalError("minus error!")
    }
    
    print("result === nadd == \(nadd) badd == \(badd)")
    print("result === nminus == \(nminus) bminus == \(bminus)")
}


