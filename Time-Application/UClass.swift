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
    let time: String
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
        
        let subject = json["subject"].string!
        if let subjectType = json["subjectType"].string {
            title = "\(subjectType.uppercaseFirst) \(subject)"
        } else {
            title = "\(subject)"
        }
        
        let (timeBegin, timeEnd) = (json["time_begin"].string!, json["time_end"].string!)
        time = "\(timeBegin) – \(timeEnd)"
        
        unit = json["unit"].string!
        
        self.TSBegin = TSBegin
        self.TSEnd = TSEnd
        
        lunapark = json["lunapark"].array!.map {ULocation(from: $0)}
    }
}
