//
//  Updatable.swift
//  Time-Application
//
//  Created by Даниил on 29.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit

protocol Updatable {
    func refresh(_ sender: AnyObject)
    func update()
}
