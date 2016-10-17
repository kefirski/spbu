//
//  Time.swift
//  Time-Application
//
//  Created by Даниил on 19.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

struct Time {
    static var now: Int {
        return Int(Date().timeIntervalSince1970)
    }
}
