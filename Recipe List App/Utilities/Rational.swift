//
//  Rational.swift
//  Recipe List App
//
//  Created by Lucas Van Tilburg on 24/6/21.
//

import Foundation

struct Rational {

    static func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        
        // GCD(0, b) = b
        if a == 0 { return b }
        
        // GCD(a, 0) = a
        if b == 0 { return a }
        
        // Otherwise, GCD(a, b) = GCD(b, remainder)
        return greatestCommonDivisor(b, a % b)
    }
    
}
