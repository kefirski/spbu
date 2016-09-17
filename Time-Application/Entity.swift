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
    let JSON_URI: String?
    let URI: String?
    
    let rawData: [JSON]?
    
    init(from json: JSON, withRawData: Bool = false) {
        self.title = json["title"].string!
        self.JSON_URI = json["JSON_URI"].string
        self.URI = json["URI"].string
        
        if withRawData {
            let range = 1...(json.count-1)
            rawData = range.map {json["\($0)"]}
        } else {
            rawData = nil
        }
    }
}

class UDataElementWithForm: UDataElement {
    let form: String
    
    init(from json: JSON) {
        self.form = json["form"].string!
        super.init(from: json)
    }
}

protocol UJSONEmbed {
    var JSON_URI: String? { get }
    var URI: String? { get }
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
