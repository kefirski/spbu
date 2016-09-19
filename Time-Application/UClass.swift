//
//  UClass.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON

class UClass {
    let location: String?
    
    let title: String
    let type: String?
    
    let time: String
    let timeBegin: String
    let timeEnd: String
    
    let unit: String
    
    let TSBegin: Int
    let TSEnd: Int
    
    let lunapark: [ULocation]

    init?(from json: JSON) {
        
        guard let TSBegin = json["TS_begin"].int, let TSEnd = json["TS_end"].int else {
            // this class should be dropped out
            return nil
        }

        location = json["location"].string
        
        title = json["subject"].string!.uppercaseFirst
        
        if let subjectType = json["subjectType"].string?.uppercaseFirst {
            type = subjectType
        } else {
            type = nil
        }
        
        let (timeBegin, timeEnd) = (json["time_begin"].string!, json["time_end"].string!)
        time = "\(timeBegin) – \(timeEnd)"
        self.timeBegin = timeBegin
        self.timeEnd = timeEnd
        
        unit = json["unit"].string!
        
        self.TSBegin = TSBegin
        self.TSEnd = TSEnd
        
        lunapark = json["lunapark"].array!.map {ULocation(from: $0)}
    }
    
    var mainTitle: String {
        if let type = type {
            return "\(type)\n\(title)"
        } else {
            return title
        }
    }
    
    var isEnded: Bool {
        return TSEnd > Time.now ? false : true
    }
}
