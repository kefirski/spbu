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

/// Represents the level of the timetable (i.e. root level is .l1)
enum ULevel: Int {
    case l1 = 1, l2, l3, l4, l5, widget
}

extension ULevel {
    /// Returns level mark (i.e for level .l1 returns "?L1")
    var mark: String {
        return "\(rawValue)"
    }
}

enum UService {
    case getData(path: String, onLevel: ULevel)
}

extension UService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://tt.rusunix.org")!
    }
    
    /// Returns path embed with level mark (i.e. for root level with "root.json" path and .l1 level,
    /// it returns "root.json?L1")
    var path: String {
        switch self {
        case .getData(let path, _):
            return path
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getData(_, let level):
            return ["level": level.mark]
        }
    }
    
    var sampleData: Data {
        return "".utf8EncodedData
    }
    
    var task: Task {
        return .request
    }
}

extension String {
    
    var urlEscapedString: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8EncodedData: Data {
        return data(using: .utf8)!
    }
}
