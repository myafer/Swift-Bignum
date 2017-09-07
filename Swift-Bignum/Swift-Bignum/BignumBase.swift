//
//  BignumBase.swift
//  Swift-Bignum
//
//  Created by afer on 2017/9/6.
//  Copyright © 2017年 afer. All rights reserved.
//

import Cocoa

class BignumBase: NSObject {
    
    var value: String?
    var sign: Bool?
    
    init(_ intvalue: Int) {
        let uintvalue = intvalue >= 0 ? intvalue : -1 * intvalue
        self.value = "\(uintvalue)"
        self.sign = intvalue >= 0 ? false : true
    }
    
    init(value: String, sign: Bool = false) {
        self.value = value
        self.sign = sign
    }
    
    init(bnum: BignumBase, sign: Bool = false) {
        self.value = bnum.value
        self.sign = sign
    }
    
    override var description: String {
        return (sign! == true ? "-" : "") + "\(value!)"
    }
    
    static func add(_ a: BignumBase, _ b: BignumBase) -> BignumBase {
        
        // a b 都为负数 
        if a.sign! && b.sign! {
            return BignumBase.init(bnum: BignumBase.uintadd(a, b), sign: true)
        }
        // a 为负数
        if a.sign! && !b.sign! {
            return BignumBase.minus(b, a)
        }
        // b 为负数
        if !a.sign! && b.sign! {
            return BignumBase.minus(a, b)
        }
        
        if !a.sign! && !b.sign! {
            return BignumBase.init(bnum: BignumBase.uintadd(a, b), sign: false)
        }
        // will never been executed
        return BignumBase(value: "NaN", sign: true)
    }
    
    func uintminusTo(_ a: BignumBase) -> BignumBase {
        let selfre = self.value?.reverseArray()
        let are = a.value?.reverseArray()
        let max = self.isBiggerThanUint(a) ? selfre : are
        let min = max! == selfre! ? are : selfre
        var tmp = 0
        var result = ""
        for (index, maxch) in (max?.enumerated())! {
            if index < (min?.count)! {
                let maxchint = Int("\(maxch)")!
                let minch = (min?[index])!
                let minint = Int("\(minch)")!
                let minusResult = maxchint + tmp - minint
                tmp = 0
                if minusResult >= 0 {
                    result.append("\(minusResult)")
                } else {
                    result.append("\(minusResult + 10)")
                    tmp = -1
                }
            } else {
                let maxchint = Int("\(maxch)")!
                if index == (max?.count)! - 1 && maxchint + tmp == 0 {
                    break
                } else {
                    result.append("\(maxchint + tmp)")
                    tmp = 0
                }
            }
        }
        // drop 0
        let reResult = result.reverse()
        var trueResult = ""
        var numflag = false
        for ch in reResult.toArray() {
            if ch != "0" {
                trueResult.append("\(ch)")
                numflag = true
                continue
            }
            if numflag {
                trueResult.append("\(ch)")
            }
        }
        return BignumBase(value: trueResult)
        
    }
    
    static func minus(_ a: BignumBase, _ b: BignumBase) -> BignumBase {
        // + -
        if !a.sign! && b.sign! {
            let result = BignumBase.uintadd(a, b)
            result.sign = false
            return result
        } else if a.sign! && b.sign! { // -  -
            return BignumBase(bnum: b.uintminusTo(a), sign: !b.isBiggerThanUint(a))
        } else if a.sign! && !b.sign! { // - +
            let result = BignumBase.uintadd(a, b)
            result.sign = true
            return result
        } else { // + +
            return BignumBase(bnum: a.uintminusTo(b), sign: !a.isBiggerThanUint(b))
        }
    }
    
    static func uintadd(_ a: BignumBase, _ b: BignumBase) -> BignumBase {
        let are = a.value?.reverseArray()
        let bre = b.value?.reverseArray()
        let max = (are?.count)! > (bre?.count)! ? are : bre
        let min = max! == bre! ? are : bre
        var reValue = [String]()
        var plus = 0
        for (index, character) in max!.enumerated() {
            if (min?.count)! > index {
                let result = character.toInt() + min![index].toInt() + plus
                plus = result >= 10 ? 1 : 0
                reValue.append("\(result % 10)")
            } else {
                let result = character.toInt() + plus
                plus = result >= 10 ? 1 : 0
                reValue.append("\(result % 10)")
            }
        }
        if plus == 1 {
            reValue.append("1")
        }
        return BignumBase(value: reValue.reversed().joined(), sign: true)
    }
    
    func isBiggerThan(_ a: BignumBase) -> Bool {
        if self.sign! && a.sign! {
            return !self.isBiggerThanUint(a)
        } else if !(self.sign!) && a.sign! {
            return true
        } else if self.sign! && !(a.sign!) {
            return false
        } else {
           return self.isBiggerThanUint(a)
        }
    }
    
    func isBiggerThanUint(_ a: BignumBase) -> Bool {
        if (self.value?.characters.count)! > (a.value?.characters.count)! {
            return true
        } else if (self.value?.characters.count)! == (a.value?.characters.count)! {
            if self.isBiggerThanEqualLengthUint(a) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func isBiggerThanEqualLengthUint(_ a: BignumBase) -> Bool {
        if self.value?.characters.count != a.value?.characters.count {
            fatalError("Two number is not equal length!")
        }
        let selfre = self.value?.toArray()
        let are = a.value?.toArray()
        for (index, selfch) in (selfre?.enumerated())! {
            let selfint = Int("\(selfch)")!
            let arech = (are?[index])!
            let aint = Int("\(arech)")!
            if selfint > aint {
                return true
            } else if selfint < aint {
                return false
            } else {
                // if is equal
            }
        }
        return true
    }
    

}
