//
//  Color.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit

struct UColor {
    static let backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9882352941, blue: 0.9921568627, alpha: 1)
    static let redContentColor = #colorLiteral(red: 0.2039215686, green: 0.3843137255, blue: 0.9960784314, alpha: 1)
    static let greyContentColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    static let lightGreyContentColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    static let lightBlueContentColor = #colorLiteral(red: 0.8, green: 0.9019607843, blue: 1, alpha: 1)
}

extension UIView {
    func setBackgroundColor() {
        backgroundColor = UColor.backgroundColor
    }
}
