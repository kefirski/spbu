//
//  Optional.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

extension Optional {
    
    var isNil: Bool {
        switch self {
        case .some( _):
            return false
        case .none:
            return true
        }
    }
    
}
