//
//  ULocation.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ULLPair = (Double, Double)

class ULocation {
    
    let title: String
    let latitude: Double
    let longitude: Double
    
    init(from json: JSON) {
        title = json["location"].string!
        latitude = json["latitude"].double!
        longitude = json["longitude"].double!
    }
    
    func llPair() -> ULLPair {
        return (latitude, longitude)
    }
    
}
