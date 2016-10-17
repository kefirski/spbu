//
//  Metadata.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Metadata {
    
    let uri: String
    let level: Int
    let timestamp: Int
    let nextWeek: String?
    let previousWeek: String?
    let periodEnd: Int?
    let isMainPeriod: Bool
    
    init(from json: JSON) {
        
        self.uri = json["URI"].string!
        self.level = json["level"].int!
        self.timestamp = json["timestamp"].int!
        self.nextWeek = json["next-week"].string
        self.previousWeek = json["prev-week"].string
        self.periodEnd = json["period_end"].int
        
        isMainPeriod = json["is_main_period"].int == 1
    }
}
