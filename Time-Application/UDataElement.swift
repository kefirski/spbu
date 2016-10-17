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
    let jsonURI: String?
    let uri: String?
    
    let rawData: [JSON]?
    
    init(from json: JSON, withRawData: Bool = false) {
        
        title = json["title"].string!
        jsonURI = json["JSON_URI"].string
        uri = json["URI"].string
        
        if withRawData {
            
            let count = json.count - 1
            
            if count != 0 {
                let range = 1...count
                rawData = range.map { json["\($0)"] }
            } else {
                rawData = []
            }
            
        } else {
            rawData = nil
        }
    }
}

final class UDataElementStudyDay: UDataElement {
    
    let timestampBegin: Int
    let timestampEnd: Int
    var classes: [UClass]!
    
    init?(from json: JSON) {
        
        guard let timestampBegin = json["TS_begin"].int,
            let timestampEnd = json["TS_end"].int else {
                
            // I am afraid that in some cases timestamps could be not included in data
            // so this day should be dropped out
            return nil
        }
        
        self.timestampBegin = timestampBegin
        self.timestampEnd = timestampEnd
        
        super.init(from: json, withRawData: true)
        
        classes = rawData!.flatMap(UClass.init)
    }
    
    var isEnded: Bool {
        return timestampEnd <= Time.now
    }
}

final class UDataElementWithForm: UDataElement {
    
    let form: String
    
    init(from json: JSON) {
        form = json["form"].string!
        super.init(from: json)
    }
}

final class GroupedUDataElement {
    
    let form: String
    let groupedElements: [UDataElementWithForm]
    
    init(form: String, elements: [UDataElementWithForm]) {
        self.form = form
        groupedElements = elements
    }
}

protocol UJSONEmbed {
    var jsonURI: String? { get }
    var uri: String? { get }
}
