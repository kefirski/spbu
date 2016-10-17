//
//  Defaults.swift
//  Time-Application
//
//  Created by Даниил on 26.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

struct Defaults {
    
    static func saveUserSchedule(uri: String) {
        let defaults = UserDefaults(suiteName: "group.daniilGavrilov.TimeApplication")!
        defaults.set(uri, forKey: "userSchedule")
    }
    
    static func userSchedule() -> String? {
        let defaults = UserDefaults(suiteName: "group.daniilGavrilov.TimeApplication")!
        return defaults.string(forKey: "userSchedule")
    }
    
    static func deleteUserSchedule() {
        let defaults = UserDefaults(suiteName: "group.daniilGavrilov.TimeApplication")!
        defaults.removeObject(forKey: "userSchedule")
    }
}
