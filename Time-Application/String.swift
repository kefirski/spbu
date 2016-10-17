//
//  String.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

extension String {
    
    subscript(i: Int) -> Character {
        return self[characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript(i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript(range: Range<Int>) -> String {
        return substring(with:
            Range(characters.index(startIndex,
                                   offsetBy: range.lowerBound) ..< characters.index(startIndex,
                                                                                offsetBy: range.upperBound)))
    }
    
    var first: String {
        return String(characters.prefix(1))
    }
    
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
}
