//
//  Color.swift
//  Time-Application
//
//  Created by Даниил on 18.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import UIKit

class UColor {
    static var backgroundColor: UIColor {
        return UIColor(netHex: 0xFBFCFD)
    }
    
    static var redContentColor: UIColor {
//        return UIColor(netHex: 0xfd363c)

        return UIColor(netHex: 0x3462fe)
    }
    
    static var greyContentColor: UIColor {
        return UIColor(netHex: 0x4f4f4f)
    }
    
    static var lightGreyContentColor: UIColor {
        return UIColor(netHex: 0xe8e8e8)
    }

}

extension UIView {
    func setBackgroundColor() {
        self.backgroundColor = UColor.backgroundColor
    }
}
