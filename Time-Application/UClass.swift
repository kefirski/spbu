//
//  UClass.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UClass {
    
    let location: String?
    
    let title: String
    let type: String?
    
    let time: String
    let timeBegin: String
    let timeEnd: String
    
    let unit: String?
    
    let timestampBegin: Int
    let timestampEnd: Int
    
    let lunapark: [ULocation]

    init?(from json: JSON) {
        
        guard let timestampBegin = json["TS_begin"].int,
            let timestampEnd = json["TS_end"].int else {
                
            // this class should be dropped out
            return nil
        }

        location = json["location"].string
        
        title = json["subject"].string!.uppercaseFirst
        type = json["subjectType"].string?.uppercaseFirst
        
        let (timeBegin, timeEnd) = (json["time_begin"].string!, json["time_end"].string!)
        
        time = "\(timeBegin) – \(timeEnd)"
        
        self.timeBegin = timeBegin
        self.timeEnd = timeEnd
        
        unit = json["unit"].string
        
        self.timestampBegin = timestampBegin
        self.timestampEnd = timestampEnd
        
        lunapark = json["lunapark"].array!.map(ULocation.init)
    }
    
    var mainTitle: String {
        if let type = type {
            return "\(type)\n\(title)"
        } else {
            return title
        }
    }
    
    var mainDescription: String? {
        if let unit = unit {
            return "\(unit)\n\(location ?? "")"
        } else {
            return location
        }
    }
    
    var isEnded: Bool {
        return timestampEnd <= Time.now
    }
}
