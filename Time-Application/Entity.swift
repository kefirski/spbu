//
//  Entity.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON

class UDataElement: UJSONEmbed {
    let title: String
    let JSON_URI: String
    let URI: String
    
    init(from json: JSON) {
        self.title = json["title"].string!
        self.JSON_URI = json["JSON_URI"].string!
        self.URI = json["URI"].string!
    }
}

protocol UJSONEmbed {
    var JSON_URI: String { get }
    var URI: String { get }
}

class Metadata {
    let URI: String
    let level: Int
    let timestamp: Int
    let nextWeek: String?
    let prevWeek: String?
    let periodEnd: Int?
    let isMainPeriod: Bool?
    
    init(from json: JSON) {
        self.URI = json["URI"].string!
        self.level = json["level"].int!
        self.timestamp = json["timestamp"].int!
        self.nextWeek = json["next-week"].string
        self.prevWeek = json["prev-week"].string
        self.periodEnd = json["period_end"].int
        if let isMainPeriodInt = json["is_main_period"].int {
            self.isMainPeriod = isMainPeriodInt == 1 ? true : false
        } else {
            self.isMainPeriod = false
        }
    }
}
