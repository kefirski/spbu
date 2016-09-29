//
//  URLOpen.swift
//  Time-Application
//
//  Created by Даниил on 28.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit

class Open {
    fileprivate static func yandexMap(on location: ULocation) {
//        let url = URL(string: "yandexmaps://maps.yandex.ru/?ll=\(location.longitude),\(location.latitude)&z=16")!
        let url = URL(string: "yandexmaps://maps.yandex.ru/?pt=\(location.longitude),\(location.latitude)&z=16&l=map")!
        UIApplication.shared.open(url)
    }
    
    fileprivate static func appstoreYandex() {
        let url = URL(string: "https://itunes.apple.com/ru/app/yandex.maps/id313877526?mt=8")!
        UIApplication.shared.open(url)
    }
    
    static func map(on location: ULocation) {
        if Open.yandexMapAvaible {
            Open.yandexMap(on: location)
        } else {
            Open.appstoreYandex()
        }
    }
    
    fileprivate static var yandexMapAvaible: Bool {
        get {
            let url = URL(string: "yandexmaps://")!
            return UIApplication.shared.canOpenURL(url)
        }
    }
    
}
