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

class UDataElementStudyDay: UDataElement {
    let TSBegin: Int
    let TSEnd: Int
    let classes: [UClass]

//    init?(from json: JSON) {
//        super.init(from: json, withRawData: true)
//        
//        guard let TSBegin = json["TS_begin"].int, let TSEnd = json["TS_end"].int else {
//            // this day should be dropped out
//            return nil
//        }
//        
//        self.TSBegin = TSBegin
//        self.TSEnd = TSEnd
//        
//    }
}

class UDataElementWithForm: UDataElement {
    let form: String
    
    init(from json: JSON) {
        self.form = json["form"].string!
        super.init(from: json)
    }
}

class GroupedUDataElement {
    let form: String
    let groupedElements: [UDataElementWithForm]
    
    init(form: String, elements: [UDataElementWithForm]) {
        self.form = form
        groupedElements = elements
    }
}

protocol UJSONEmbed {
    var JSON_URI: String? { get }
    var URI: String? { get }
}

