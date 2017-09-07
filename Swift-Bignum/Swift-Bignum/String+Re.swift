//
//  String+Re.swift
//  Swift-Bignum
//
//  Created by afer on 2017/9/6.
//  Copyright © 2017年 afer. All rights reserved.
//

import Cocoa

extension String {
    func reverse() -> String{
        var returnString: String = ""
        for ch in self.characters.reversed() {
            returnString.append(ch)
        }
        return returnString
    }
    
    func reverseArray() -> [Character] {
        var returnCharacterArray = [Character]()
        for ch in self.characters.reversed() {
            returnCharacterArray.append(ch)
        }
        return returnCharacterArray
    }
    
    func toArray() -> [Character] {
        var returnCharacterArray = [Character]()
        for ch in self.characters {
            returnCharacterArray.append(ch)
        }
        return returnCharacterArray
    }
    
}
