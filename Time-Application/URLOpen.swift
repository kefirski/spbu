//
//  URLOpen.swift
//  Time-Application
//
//  Created by Даниил on 28.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit

struct Open {
    
    private static func yandexMap(on location: ULocation) {
        
        let url = URL(string: "yandexmaps://maps.yandex.ru/?pt=\(location.longitude),\(location.latitude)&z=16&l=map")!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private static func appstoreYandex() {
        let url = URL(string: "https://itunes.apple.com/ru/app/yandex.maps/id313877526?mt=8")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func map(on location: ULocation) {
        if yandexMapAvailable {
            yandexMap(on: location)
        } else {
            appstoreYandex()
        }
    }
    
    private static var yandexMapAvailable: Bool {
        let url = URL(string: "yandexmaps://")!
        return UIApplication.shared.canOpenURL(url)
    }
}
