//
//  Service.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

import Moya
import Alamofire

enum ULevel: Int {
    // represents level of timetable (i.e. root level is .l1)
    case l1 = 1, l2, l3, l4, l5
    
    // returns level mark (i.e for level .l1 returns "?L1")
    var mark: String {
//        return "\\u{3F}" + "L\(self.rawValue)"
        return ""

    }
}

enum UService {
    case getData(path: String, onLevel: ULevel)
}

extension UService: TargetType {
    var baseURL: URL {
        return URL(string: "https://tt.rusunix.org")!
    }
    
    var path: String {
    // returns path embed with level mark (i.e. for root level with "root.json" path and .l1 level, it returns "root.json?L1")
        switch self {
            case .getData(let path, let level) :
                return path + level.mark
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
        return "".UTF8EncodedData
    }
    
    var task: Task {
        return .request
    }
}

extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    var UTF8EncodedData: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

